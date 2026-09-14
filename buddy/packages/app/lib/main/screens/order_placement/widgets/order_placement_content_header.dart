import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/colors.gen.dart';

class OrderPlacementContentHeader extends HookWidget {
  final int index;
  final List<String> items;

  const OrderPlacementContentHeader({
    super.key,
    required this.index,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    const bulletSize = 16.0;
    final spacersWidth = useState(<int, double>{});
    final itemsWidth = useState(<int, double>{});
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: (bulletSize / 2) - 1),
            child: Row(
              children: [
                SizedBox(
                  width: (itemsWidth.value[0] ?? 0) / 2,
                ),
                for (int i = 0; i < items.length - 1; i++) ...[
                  Center(
                    child: Container(
                      height: 2,
                      width: let(() {
                        final spacerWidth = spacersWidth.value[i] ?? 0.0;
                        final itemWidth = itemsWidth.value[i] ?? 0.0;
                        final nextItemWidth = itemsWidth.value[i + 1] ?? 0.0;
                        return spacerWidth + (itemWidth / 2) + (nextItemWidth / 2);
                      }),
                      color: (index > i) ? Theme.of(context).primaryColor : ColorName.neutral10,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              for (final entry in items.asMap().entries) ...[
                MeasureWidget(
                  onSizeChanged: (size) => itemsWidth.value = itemsWidth.value.plus(
                    entry.key,
                    size.width,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: bulletSize,
                        height: bulletSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index >= entry.key ? Theme.of(context).primaryColor : ColorName.neutral10,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: (index > entry.key).let((selected) {
                            if (selected) {
                              return Icon(
                                Icons.check,
                                size: 12,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),
                              );
                            }
                          }),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.value,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
                if (items.lastIndex != entry.key) ...[
                  Expanded(
                    child: MeasureWidget(
                      onSizeChanged: (size) => spacersWidth.value = spacersWidth.value.plus(
                        entry.key,
                        size.width,
                      ),
                      child: const SizedBox(
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                  )
                ],
              ],
            ],
          ),
        ],
      ),
    );
  }
}
