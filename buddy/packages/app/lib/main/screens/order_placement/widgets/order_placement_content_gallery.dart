import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

class OrderPlacementContentGallery extends HookWidget {
  final List<(XFile? local, String? remote)> items;
  final void Function(int)? onItemClicked;
  final void Function(int)? onRemoveClicked;

  const OrderPlacementContentGallery({
    super.key,
    required this.items,
    this.onItemClicked,
    this.onRemoveClicked,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const padding = 8.0;
        final bigImageSize = (constraints.maxWidth * 0.75) - padding;
        final smallImageSize = (bigImageSize - (padding * 2)) / 3;
        return Row(
          children: [
            Clickable(
              indicator: ClickableIndicator.nothing,
              onTap: onItemClicked != null ? () => onItemClicked!(0) : null,
              child: Builder(builder: (context) {
                final item = items.getAtOrNull(0);
                final child = item?.child;
                return _OrderPlacementContentGalleryImage(
                  image: child ?? Assets.images.imageCamera.image(),
                  size: bigImageSize,
                  onRemoveClicked: item?.$2 != null &&
                          child != null &&
                          onRemoveClicked != null
                      ? () => onRemoveClicked!(0)
                      : null,
                );
              }),
            ),
            const SizedBox(width: padding),
            Column(
              children: [
                for (int i = 1; i < 4; i++) ...[
                  if (i != 1) ...[
                    const SizedBox(height: padding),
                  ],
                  Builder(builder: (context) {
                    final item = items.getAtOrNull(i);
                    final child = item?.child;
                    return Clickable(
                      indicator: ClickableIndicator.nothing,
                      onTap: onItemClicked != null
                          ? () => onItemClicked!(i)
                          : null,
                      child: _OrderPlacementContentGalleryImage(
                        image: child ??
                            Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: i.let((it) {
                                if (it == 3) {
                                  return Assets.images.iconGalleryOutlinedPlus
                                      .image();
                                } else {
                                  return Assets.images.iconGalleryOutlinedFilled
                                      .image();
                                }
                              }),
                            ),
                        size: smallImageSize,
                        onRemoveClicked: item?.$2 != null &&
                                child != null &&
                                onRemoveClicked != null
                            ? () => onRemoveClicked!(i)
                            : null,
                      ),
                    );
                  }),
                ],
              ],
            )
          ],
        );
      },
    );
  }
}

class _OrderPlacementContentGalleryImage extends StatelessWidget {
  final Widget image;
  final double size;
  final VoidCallback? onRemoveClicked;

  const _OrderPlacementContentGalleryImage({
    required this.image,
    required this.size,
    this.onRemoveClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(size / 4)),
          child: SizedBox(
            width: size,
            height: size,
            child: image,
          ),
        ),
        if (onRemoveClicked != null) ...[
          Positioned(
            right: size / 28,
            top: size / 28,
            child: Clickable(
              onTap: onRemoveClicked,
              child: const Icon(
                Icons.remove_circle,
                size: 28,
                color: ColorName.error,
              ),
            ),
          ),
        ]
      ],
    );
  }
}

extension on (XFile? local, String? remote)? {
  Widget? get child {
    final local = this?.$1;
    final remote = this?.$2;
    if (remote != null) {
      return Image.network(
        remote ?? '',
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return LoadingOverlay(
            isVisible: true,
            child: local == null
                ? child
                : Image(image: XFileImageProvider(local), fit: BoxFit.cover),
          );
        },
      );
    }

    if (local != null) {
      return LoadingOverlay(
        isVisible: true,
        child: Image(image: XFileImageProvider(local), fit: BoxFit.cover),
      );
    }

    return null;
  }
}
