import 'package:flutter/material.dart';

class LifecycleObserver extends StatefulWidget {
  final Widget child;
  final void Function(AppLifecycleState state)? onChanged;

  const LifecycleObserver({
    Key? key,
    required this.child,
    this.onChanged,
  }) : super(key: key);

  @override
  _LifecycleObserverState createState() => _LifecycleObserverState();
}

class _LifecycleObserverState extends State<LifecycleObserver> {
  _LifecycleBinder? binder;

  @override
  void initState() {
    super.initState();
    binder = _LifecycleBinder(widget.onChanged);
    WidgetsBinding.instance?.addObserver(binder!);
  }

  @override
  void dispose() {
    super.dispose();
    if (binder != null) {
      WidgetsBinding.instance?.removeObserver(binder!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _LifecycleBinder with WidgetsBindingObserver {
  final void Function(AppLifecycleState state)? onChanged;
  AppLifecycleState? lastState;

  _LifecycleBinder(this.onChanged);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state != lastState) {
      lastState = state;
      onChanged?.call(state);
    }
  }
}
