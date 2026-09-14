import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../hooks/flutter_hooks.dart';

class WorkerApplicationFormInputField extends HookWidget {
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final String? value;
  final void Function(String value)? onValueChanged;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;

  const WorkerApplicationFormInputField({
    super.key,
    this.inputFormatters,
    this.hint,
    this.onValueChanged,
    this.value,
    this.textCapitalization,
    this.keyboardType,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: value ?? '');
    useTextEditingControllerFunctionalEffect(controller, value ?? '', onValueChanged);
    return FormBuilderTextField(
      controller: controller,
      autofocus: false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      inputFormatters: inputFormatters ?? [],
      textAlign: textAlign ?? TextAlign.left,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintMaxLines: 1,
        hintText: hint,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
      maxLines: 1,
      name: 'textfield',
    );
  }
}
