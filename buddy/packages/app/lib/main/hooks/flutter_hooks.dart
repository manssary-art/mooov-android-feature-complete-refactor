import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

usePostFrameEffect(
  Dispose? Function() effect, [
  List<Object?>? keys,
]) {
  useEffect(() {
    var disposed = false;
    Dispose? dispose;
    if (WidgetsBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      dispose = effect();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (disposed) return;
        dispose = effect();
      });
    }
    return () {
      disposed = true;
      dispose?.call();
    };
  }, keys);
}

void useTextEditingControllerFunctionalEffect(
  TextEditingController controller,
  String text, [
  void Function(String)? onChanged,
]) {
  useEffect(() {
    final listener = () => onChanged?.call(controller.text);
    controller.addListener(listener);
    return () => controller.removeListener(listener);
  }, [controller, onChanged]);
  usePostFrameEffect(() {
    if (controller.value.text != text) controller.text = text;
    return null;
  }, [controller, controller.value.text, text]);
}

Future<void> Function() useAwaitWhile(
  bool isWorking, [
  Duration timeout = const Duration(seconds: 10),
]) {
  final controller = useMemoized(() => StreamController<int>.broadcast());
  useValueChanged<bool, void>(isWorking, (prev, __) {
    if (prev && !isWorking) {
      controller.add(DateTime.now().millisecondsSinceEpoch);
    }
  });
  return () async => await controller.stream.first.timeout(timeout);
}

void Function(String value) useShowSnackBar(BuildContext context) {
  final contextRef = useRef(context);
  return useCallback((String value) {
    ScaffoldMessenger.of(contextRef.value)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
  }, []);
}

ValueListenable<T> useUpdateState<T>(T value) {
  final notifier = useMemoized(() => _UseUpdateStateNotifier<T>(value));
  useEffect(() => notifier.dispose, [notifier]);
  notifier.value = value;
  return notifier;
}

class _UseUpdateStateNotifier<T> extends ValueNotifier<T> {
  final ObjectRef<T> _ref;

  _UseUpdateStateNotifier(T value)
      : _ref = ObjectRef<T>(value),
        super(value);

  @override
  T get value => _ref.value;

  @override
  set value(T newValue) {
    if (_ref.value == newValue) {
      return;
    }
    _ref.value = newValue;
    if (WidgetsBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      notifyListeners();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
