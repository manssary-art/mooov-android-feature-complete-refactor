import 'package:flutter/material.dart';

class DeferredBuilder extends StatefulWidget {
  final WidgetBuilder builder;
  final ValueGetter<Future<dynamic>?>? loadLibrary;

  const DeferredBuilder({
    super.key,
    required this.loadLibrary,
    required this.builder,
  });

  @override
  State<DeferredBuilder> createState() => _DeferredBuilderState();
}

class _DeferredBuilderState extends State<DeferredBuilder> {
  final Future<dynamic> defaultFuture = Future.value(null);
  late Future<dynamic>? _loadLibrary;

  @override
  void initState() {
    _loadLibrary = widget.loadLibrary?.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadLibrary ?? defaultFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return UnableToLoadTryAgain(
            onTryAgainClick: () => setState(() {
              _loadLibrary = widget.loadLibrary?.call();
            }),
          );
        }

        return widget.builder(context);
      },
    );
  }
}

class UnableToLoadTryAgain extends StatelessWidget {
  final VoidCallback onTryAgainClick;

  const UnableToLoadTryAgain({
    super.key,
    required this.onTryAgainClick,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Unable to load content"),
          Container(height: 16),
          ElevatedButton(
            onPressed: onTryAgainClick,
            child: const Text("Try again"),
          )
        ],
      ),
    );
  }
}
