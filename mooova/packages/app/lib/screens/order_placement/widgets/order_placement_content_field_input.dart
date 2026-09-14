import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/hooks/flutter_hooks.dart';

class OrderPlacementContentFieldInput extends HookWidget {
  final String hint;
  final String content;
  final ValueSetter<String>? onContentChanged;
  final Widget? leading;
  final Widget? trailing;
  final TextAlign textAlign;

  const OrderPlacementContentFieldInput({
    super.key,
    required this.hint,
    this.onContentChanged,
    this.content = '',
    this.leading,
    this.trailing,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    useTextEditingControllerFunctionalEffect(controller, content, onContentChanged);
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: ListTile(
        leading: leading,
        trailing: trailing,
        dense: true,
        title: FormBuilderTextField(
          controller: controller,
          name: 'OrderPlacementContentFieldInput.$hint',
          style: Theme.of(context).textTheme.bodyLarge,
          enabled: onContentChanged != null,
          textCapitalization: TextCapitalization.sentences,
          textAlign: textAlign,
          decoration: InputDecoration(
            hintMaxLines: 10,
            hintText: hint,
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
