part of 'preview_app.dart';

class _PreviewToolsSelectScreenSection extends HookWidget {
  final ValueNotifier<List<_PreviewContainer>> containers;
  final ValueNotifier<int> selectedIndex;
  final ValueSetter<int> onSaveSelectedScreen;

  const _PreviewToolsSelectScreenSection({
    required this.containers,
    required this.selectedIndex,
    required this.onSaveSelectedScreen,
  });

  @override
  Widget build(BuildContext context) {
    const tileHeight = 60.0;
    final selectedIndex = useValueListenable(this.selectedIndex);
    final containers = useValueListenable(this.containers);
    final scrollController = useScrollController(initialScrollOffset: tileHeight * selectedIndex);
    return ToolPanelSection(
      title: 'Screen Preview',
      children: [
        GestureDetector(
          onTap: () {
            final theme = Theme.of(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Theme(
                  data: theme,
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text('Screen preview'),
                    ),
                    body: ListView.builder(
                      controller: scrollController,
                      itemCount: containers.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: tileHeight,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                this.selectedIndex.value = index;
                                onSaveSelectedScreen(index);
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                title: Text(containers[index].name),
                                textColor: selectedIndex == index ? Colors.red : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(containers[selectedIndex].name),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }
}
