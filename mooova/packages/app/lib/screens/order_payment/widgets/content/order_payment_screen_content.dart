import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../ext/card_brand_string_ext.dart';
import '../../models/available_payment_methods.dart';
import '../order_payment_available_method_list_item.dart';
import '../order_payment_card_info_field.dart';
import '../order_payment_promo_code_field.dart';

part 'order_payment_screen_content_error.dart';

part 'order_payment_screen_content_loaded_card_info.dart';

part 'order_payment_screen_content_loaded_select_method.dart';

part 'order_payment_screen_content_loading.dart';

class _OrderPaymentScreenScaffold extends HookWidget {
  final VoidCallback onNavBackClicked;
  final Widget body;

  const _OrderPaymentScreenScaffold({
    super.key,
    required this.onNavBackClicked,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: kToolbarHeight * 2,
        leading: BackButton(
          onPressed: onNavBackClicked,
        ),
        title: Center(
          child: Text(
            LocaleKeys.PaymentMethod.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ScaffoldRoundedBody(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: body,
      ),
    );
  }
}
