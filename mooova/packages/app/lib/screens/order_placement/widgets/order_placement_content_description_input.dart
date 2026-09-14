import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../core/hooks/flutter_hooks.dart';

class OrderPlacementContentDescriptionInput extends HookWidget {
  final String title;
  final String content;
  final ValueSetter<String>? onContentChanged;

  const OrderPlacementContentDescriptionInput({
    super.key,
    required this.title,
    this.onContentChanged,
    this.content = '',
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    useTextEditingControllerFunctionalEffect(controller, content, onContentChanged);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Container(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          constraints: const BoxConstraints(minHeight: 120),
          width: double.infinity,
          child: FormBuilderTextField(
            name: 'OrderDetailsTranslatableDescription.description',
            controller: controller,
            style: Theme.of(context).textTheme.bodyLarge,
            enabled: onContentChanged != null,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintMaxLines: 10,
              hintText: LocaleKeys.CommentPlaceHolder.tr(),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            maxLines: null,
          ),
        ),
      ],
    );
  }
}
