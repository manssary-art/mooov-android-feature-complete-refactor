import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/hooks/flutter_hooks.dart';

class AuthenticationTextField extends HookWidget {
  final String name;
  final ValueSetter<String> onChanged;
  final String value;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const AuthenticationTextField({
    super.key,
    required this.name,
    required this.onChanged,
    required this.value,
    this.keyboardType,
    this.hintText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: value);
    useTextEditingControllerFunctionalEffect(controller, value, onChanged);
    return FormBuilderTextField(
      name: name,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      cursorColor: Theme.of(context).colorScheme.background,
      textCapitalization: keyboardType == TextInputType.name ? TextCapitalization.words : TextCapitalization.none,
      decoration: InputDecoration(
        counterStyle: null,
        counterText: "",
        isDense: true,
        hintText: hintText,
        contentPadding: const EdgeInsets.only(bottom: 8),
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black.withOpacity(0.25),
            ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
    );
  }
}
