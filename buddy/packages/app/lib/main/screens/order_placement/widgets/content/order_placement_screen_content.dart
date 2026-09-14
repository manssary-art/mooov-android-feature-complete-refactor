import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../models/order_address_model.dart';
import '../../../../../models/types/order_size_type.dart';
import '../../../../../models/types/order_type.dart';
import '../../../../../models/types/product_condition_type.dart';
import '../../models/order_placement_steps.dart';
import '../order_placement_content_header.dart';
import '../step_address/order_placement_step_address.dart';
import '../step_images/order_placement_step_images.dart';
import '../step_images_give_away/order_placement_step_images_give_away.dart';
import '../step_price/order_placement_step_price.dart';
import '../step_review/order_placement_step_review.dart';

part 'order_placement_screen_content_error.dart';

part 'order_placement_screen_content_loaded.dart';

part 'order_placement_screen_content_loading.dart';

class _OrderPlacementScreenScaffold extends StatelessWidget {
  final Widget child;
  final int index;
  final List<String> items;

  const _OrderPlacementScreenScaffold({
    super.key,
    required this.child,
    required this.index,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: OrderPlacementContentHeader(
          index: index,
          items: items,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: child,
      ),
    );
  }
}
