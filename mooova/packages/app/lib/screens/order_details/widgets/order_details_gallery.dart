import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/assets.gen.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OrderDetailsPageGallery extends HookWidget {
  final List<String> images;
  final ValueSetter<int> onImageClicked;

  const OrderDetailsPageGallery({
    Key? key,
    required this.images,
    required this.onImageClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    return SizedBox(
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PhotoViewGallery.builder(
            allowImplicitScrolling: true,
            pageController: pageController,
            itemCount: images.length,
            loadingBuilder: (context, event) => const Center(
              child: LoadingIndicator(),
            ),
            builder: (context, index) {
              final image = images[index];
              return PhotoViewGalleryPageOptions.customChild(
                disableGestures: true,
                child: Clickable(
                  onTap: () => onImageClicked(index),
                  child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, _, __) => Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: const Center(
                        child: LoadingIndicator(),
                      ),
                    ),
                    errorWidget: (context, _, __) => Assets.images.iconAppLauncher.image(),
                    fit: BoxFit.fitWidth,
                    imageUrl: image,
                    alignment: Alignment.center,
                  ),
                ),
              );
            },
          ),
          if (images.length > 1) ...[
            Positioned(
              bottom: 24,
              child: AnimatedBuilder(
                animation: pageController,
                builder: (context, child) {
                  return AnimatedSmoothIndicator(
                    activeIndex: pageController.page?.toInt() ?? 0,
                    count: images.length,
                    onDotClicked: (index) => pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    ),
                    effect: WormEffect(
                      activeDotColor: Theme.of(context).primaryColor,
                      dotColor: Theme.of(context).disabledColor,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
