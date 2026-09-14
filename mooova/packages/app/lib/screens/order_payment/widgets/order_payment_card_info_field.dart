import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/colors.gen.dart';

import '../../../core/hooks/flutter_hooks.dart';
import '../ext/card_brand_detector.dart';
import '../ext/card_brand_string_ext.dart';

class OrderPaymentCardInfoField extends HookWidget {
  final String? cardNumber;
  final String? cvc;
  final String? expMonth;
  final String? expYear;
  final void Function(String?) onCardNumberChanged;
  final void Function(String?) onCvcChanged;
  final void Function(String?) onExpMonthChanged;
  final void Function(String?) onExpYearChanged;

  const OrderPaymentCardInfoField({
    super.key,
    required this.cardNumber,
    required this.cvc,
    required this.expMonth,
    required this.expYear,
    required this.onCardNumberChanged,
    required this.onCvcChanged,
    required this.onExpMonthChanged,
    required this.onExpYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    final mmYyInputMask = useMemoized(() => InputFormatterMask(
          mask: '##/##',
          filter: {"#": RegExp(r'[0-9]')},
          type: InputFormatterMask$Type.lazy,
        ));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          (detectCCType(cardNumber) ?? '').cardBrandAsset.image(width: 24),
          const SizedBox(width: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 120),
            child: IntrinsicWidth(
              child: _OrderPaymentCardInfoField$TextField(
                hintText: '0000 0000 0000 0000',
                onChanged: (value) {
                  onCardNumberChanged(value.takeIf((it) => it != ''));
                  if (value.length == 19 && (cardNumber ?? '').length != value.length) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                value: cardNumber ?? '',
                isValid: true,
                maxLength: 19,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 60),
            child: IntrinsicWidth(
              child: _OrderPaymentCardInfoField$TextField(
                hintText: 'MM/YY',
                onChanged: (value) {
                  final previous = ((expMonth?.toString() ?? '') + (expYear?.toString() ?? '')).characters.toList();
                  final next = mmYyInputMask.unmaskText(value).characters.toList();
                  final mm = (next.getAtOrNull(0) ?? '') + (next.getAtOrNull(1) ?? '');
                  final yy = (next.getAtOrNull(2) ?? '') + (next.getAtOrNull(3) ?? '');
                  onExpMonthChanged(mm);
                  onExpYearChanged(yy);

                  if (next.getAtOrNull(3) != null && previous.getAtOrNull(3) == null) {
                    FocusScope.of(context).nextFocus();
                  } else if (previous.isNotEmpty && next.isEmpty) {
                    FocusScope.of(context).previousFocus();
                  }
                },
                value: mmYyInputMask.maskText((expMonth?.toString() ?? '') + (expYear?.toString() ?? '')),
                isValid: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter,
                  mmYyInputMask
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 60),
            child: IntrinsicWidth(
              child: _OrderPaymentCardInfoField$TextField(
                hintText: 'CVC',
                onChanged: (value) {
                  onCvcChanged(value.takeIf((it) => it != ''));
                  if (value == '' && (cvc ?? '') != '') {
                    FocusScope.of(context).previousFocus();
                  }
                },
                value: cvc ?? '',
                maxLength: 6,
                isValid: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderPaymentCardInfoField$TextField extends HookWidget {
  final ValueSetter<String> onChanged;
  final String value;
  final String hintText;
  final int? maxLength;
  final bool isValid;
  final List<TextInputFormatter>? inputFormatters;

  const _OrderPaymentCardInfoField$TextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.value,
    this.maxLength,
    this.isValid = true,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: value);
    useTextEditingControllerFunctionalEffect(controller, value, onChanged);
    return TextField(
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: TextInputType.number,
      maxLines: 1,
      maxLength: maxLength,
      cursorColor: Theme.of(context).colorScheme.primary,
      textCapitalization: TextCapitalization.none,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isValid ? Theme.of(context).textTheme.titleMedium?.color : ColorName.error,
          ),
      decoration: InputDecoration(
        counterStyle: null,
        counterText: "",
        isDense: false,
        hintText: hintText,
        contentPadding: const EdgeInsets.all(4),
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black.withOpacity(0.25),
            ),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
    );
  }
}
