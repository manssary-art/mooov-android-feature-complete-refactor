import 'package:async/async.dart';

import '../../models/user_model.dart';
import '../../models/worker_application_form_model.dart';

abstract interface class UserWorkerRepository {
  Future<Result<UserModel>> setVehicleImage({
    required String imageUrl,
  });

  Future<Result<WorkerApplicationFormModel>> getApplicationForm();

  Future<Result<void>> createApplicationForm({
    required WorkerApplicationFormModel form,
  });

  Future<Result<void>> updateApplicationForm({
    required  WorkerApplicationFormModel form,
  });
}
