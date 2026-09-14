part of 'preview_app.dart';

class _PreviewToolsThemeSection extends HookWidget {
  const _PreviewToolsThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ToolPanelSection(
      title: 'Preview Theme',
      children: [
        ListTile(
          title: Text('Customize theme'),
          trailing: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
