import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/di.dart';
import '../../../../models/user_info_business_model.dart';
import '../../../../models/worker_application_form_model.dart';
import '../../../../repositories/upload/upload_repository.dart';
import '../../../../core/ext/riverpod_ext.dart';
import '../models/worker_application_form_status.dart';

part 'worker_application_form_side_effects_providers.dart';

part 'worker_application_form_state_providers.dart';

part 'worker_application_submit_provider.dart';

const _name = 'WorkerApplicationForm';

final _scope = ProviderScopeContainer();

final userRepositoryProvider = Provider((ref) => Di.userRepository);

final userWorkerRepositoryProvider = Provider((ref) => Di.userWorkerRepository);

final uploadRepositoryProvider = Provider((ref) => Di.uploadRepository);

final workerApplicationFormProvider = AsyncNotifierProvider<WorkerApplicationFormNotifier, WorkerApplicationFormModel>(
  name: '$_name.workerApplicationFormProvider',
  dependencies: _scope.dependencies,
  () => throw AssertionError(),
).scoped(_scope);

class WorkerApplicationFormNotifier extends AsyncNotifier<WorkerApplicationFormModel> {
  @override
  Future<WorkerApplicationFormModel> build() async {
    final userWorkerRepository = ref.watch(userWorkerRepositoryProvider);
    final workerApplicationForm = await userWorkerRepository.getApplicationForm();
    return workerApplicationForm.asFuture;
  }

  void onTryAgainClicked() async {
    if (state.hasError) {
      ref.invalidateSelf();
    }
  }
}
