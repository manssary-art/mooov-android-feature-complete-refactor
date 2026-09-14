import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../core/hooks/flutter_hooks.dart';

class ImagesViewerScreen extends StatelessWidget {
  final List<String> images;
  final int? initialIndex;
  final VoidCallback onNavBack;

  const ImagesViewerScreen({
    super.key,
    required this.images,
    required this.onNavBack,
    this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      Future.microtask(() => onNavBack());
      return Container();
    }

    return _ImagesViewerScreenContent(
      images: images,
      initialIndex: initialIndex ?? 0,
      onNavBack: onNavBack,
    );
  }
}

class _ImagesViewerScreenContent extends HookWidget {
  final List<String> images;
  final int initialIndex;
  final VoidCallback onNavBack;

  const _ImagesViewerScreenContent({
    super.key,
    required this.images,
    required this.initialIndex,
    required this.onNavBack,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CloseButton(
                    onPressed: onNavBack,
                  ),
                  if (images.length > 1) ...[
                    _ImageViewerPager(
                      pageController: pageController,
                      images: images,
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            child: PhotoViewGallery.builder(
              allowImplicitScrolling: true,
              pageController: pageController,
              itemCount: images.length,
              builder: (context, index) {
                final image = images[index];
                return PhotoViewGalleryPageOptions.customChild(
                  initialScale: PhotoViewComputedScale.contained * 1.0,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, _, __) => Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: const Center(
                        child: LoadingIndicator(),
                      ),
                    ),
                    errorWidget: (context, _, __) =>
                        Assets.images.iconAppLauncher.image(),
                    fit: BoxFit.fitWidth,
                    imageUrl: image,
                    alignment: Alignment.center,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ImageViewerPager extends HookWidget {
  final PageController pageController;
  final List<String> images;

  const _ImageViewerPager({
    super.key,
    required this.images,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    // Workaround for ERROR: "PageController.page cannot be accessed before a PageView is built with it."
    final isReady = useState(false);
    usePostFrameEffect(() {
      isReady.value = true;
      return null;
    });

    if (!isReady.value) {
      return Container();
    }

    return Row(
      children: [
        Clickable(
          onTap: () {
            final currentPage = pageController.page?.toInt();
            if (currentPage == null) return;
            final nextPage = currentPage - 1;
            if (nextPage < 0) return;
            pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
          child: Icon(
            Icons.arrow_circle_left,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            minWidth: 60,
          ),
          child: Center(
            child: AnimatedBuilder(
              animation: pageController,
              builder: (context, child) {
                return Text(
                    '${(pageController.page?.toInt() ?? 0) + 1}/${images.length}');
              },
            ),
          ),
        ),
        Clickable(
          onTap: () {
            final currentPage = pageController.page?.toInt();
            if (currentPage == null) return;
            final nextPage = currentPage + 1;
            if (nextPage > images.lastIndex) return;
            pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
          child: Icon(
            Icons.arrow_circle_right,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
        ),
      ],
    );
  }
}
