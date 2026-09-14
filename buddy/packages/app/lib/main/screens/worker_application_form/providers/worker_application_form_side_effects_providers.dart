part of '_worker_application_form_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<WorkerApplicationFormSideEffect>.broadcast(),
).scoped(_scope);

sealed class WorkerApplicationFormSideEffect {}

class WorkerApplicationFormSideEffect$NavToBack implements WorkerApplicationFormSideEffect {
  const WorkerApplicationFormSideEffect$NavToBack();
}

class WorkerApplicationFormSideEffect$ShowErrorMessage implements WorkerApplicationFormSideEffect {
  final String value;
  const WorkerApplicationFormSideEffect$ShowErrorMessage(this.value);
}
