part of 'preview_app.dart';

class _PreviewToolsOptionsSection extends HookWidget {
  final ValueNotifier<List<_PreviewContainer>> containers;
  final ValueNotifier<int> selectedIndex;

  const _PreviewToolsOptionsSection({
    super.key,
    required this.containers,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final containers = useValueListenable(this.containers);
    final selectedIndex = useValueListenable(this.selectedIndex);
    final container = useValueListenable(containers[selectedIndex].fields);
    final children = container.entries.mapNotNull((e) => e.value.build(context)).toList();
    if (children.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    return ToolPanelSection(
      title: 'Preview options',
      children: children,
    );
  }
}
