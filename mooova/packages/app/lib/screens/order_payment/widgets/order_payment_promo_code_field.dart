import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/extensions/currency_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../core/hooks/flutter_hooks.dart';

class OrderPaymentPromoCodeField extends HookWidget {
  final ValueListenable<String> promoCode;
  final ValueListenable<Money> amount;
  final ValueListenable<Money?> discount;
  final ValueListenable<Currency> currency;
  final ValueListenable<bool> isApplyingPromoCode;
  final void Function(String) onPromoCodeChanged;

  const OrderPaymentPromoCodeField({
    super.key,
    required this.promoCode,
    required this.amount,
    required this.discount,
    required this.currency,
    required this.isApplyingPromoCode,
    required this.onPromoCodeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final discount = useValueListenable(this.discount);
    final promoCode = useValueListenable(this.promoCode);
    final amount = useValueListenable(this.amount);
    final currency = useValueListenable(this.currency);
    final isApplyingPromoCode = useValueListenable(this.isApplyingPromoCode);
    final promoCodeController = useTextEditingController();
    useTextEditingControllerFunctionalEffect(promoCodeController, promoCode, onPromoCodeChanged);
    return Column(
      children: [
        Row(
          children: [
            Text(
              LocaleKeys.TotalPrice.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            const SizedBox(width: 8),
            Text(
              currency.format(amount),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            if (discount != null && discount != 0) ...[
              const SizedBox(width: 8),
              Text(
                currency.format(amount + discount),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).disabledColor,
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
            ],
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                controller: promoCodeController,
                inputFormatters: [
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) => TextEditingValue(
                      text: newValue.text?.toUpperCase() ?? '',
                      selection: newValue.selection,
                    ),
                  ),
                ],
                decoration: InputDecoration(
                  isDense: true,
                  hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).disabledColor),
                  hintText: 'Promo Code (ABC123)',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                ),
                validator: (value) => null,
                name: 'promoCode',
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              height: 40,
              width: 40,
              child: isApplyingPromoCode ? const LoadingIndicator() : Assets.images.iconTabHomeSelected.image(),
            )
          ],
        ),
      ],
    );
  }
}
