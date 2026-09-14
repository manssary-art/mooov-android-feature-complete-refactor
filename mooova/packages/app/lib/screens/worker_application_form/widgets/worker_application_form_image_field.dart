import 'package:cross_file/cross_file.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/assets.gen.dart';

class WorkerApplicationFormImageField extends HookWidget {
  final (XFile?, String?) value;
  final VoidCallback onTap;
  final AssetGenImage placeholder;

  const WorkerApplicationFormImageField({
    super.key,
    required this.value,
    required this.onTap,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    const size = 96.0;
    return Clickable(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(size / 8)),
        child: SizedBox(
          height: size,
          width: size,
          child: value.child ??
              placeholder.image(
                width: size,
                height: size,
              ),
        ),
      ),
    );
  }
}

extension on (XFile? local, String? remote)? {
  Widget? get child {
    final local = this?.$1;
    final remote = this?.$2;

    if (local != null) {
      return Image(image: XFileImageProvider(local), fit: BoxFit.cover);
    }

    if (remote != null) {
      return Image.network(
        remote,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return LoadingOverlay(
            isVisible: true,
            child: local == null ? child : Image(image: XFileImageProvider(local), fit: BoxFit.cover),
          );
        },
      );
    }

    return null;
  }
}
