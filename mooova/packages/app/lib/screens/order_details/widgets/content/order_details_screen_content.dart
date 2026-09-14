import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../models/geo_point_model.dart';
import '../../../../../models/order_model.dart';
import '../../../../../models/types/order_state_type.dart';
import '../../../../../models/types/order_type.dart';
import '../../../../../core/hooks/use_copy_to_clipboard.dart';
import '../../../../../core/hooks/use_open_on_external_map.dart';
import '../../models/order_details_display_mode.dart';
import '../order_details_address.dart';
import '../order_details_distance.dart';
import '../order_details_gallery.dart';
import '../order_details_map.dart';
import '../order_details_num_of_workers_requested.dart';
import '../order_details_owner_user_profile.dart';
import '../order_details_price_offer.dart';
import '../order_details_product_condition.dart';
import '../order_details_small_button.dart';
import '../order_details_time_picker.dart';
import '../order_details_translatable_description.dart';

part 'order_details_screen_error.dart';

part 'order_details_screen_loaded.dart';

part 'order_details_screen_loading.dart';

class _OrderDetailsScreenScaffold extends StatelessWidget {
  final VoidCallback onNavBackClicked;
  final Widget body;

  const _OrderDetailsScreenScaffold({
    super.key,
    required this.onNavBackClicked,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          body,
          Positioned(
            left: 16,
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                ),
                child: BackButton(
                  onPressed: onNavBackClicked,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
