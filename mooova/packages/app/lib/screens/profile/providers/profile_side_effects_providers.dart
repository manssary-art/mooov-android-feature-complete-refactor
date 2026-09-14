part of '_profile_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<ProfileSideEffect>.broadcast(),
).scoped(_scope);

sealed class ProfileSideEffect {}

class ProfileSideEffect$NavToHome implements ProfileSideEffect {
  const ProfileSideEffect$NavToHome();
}

class ProfileSideEffect$NavToWorkerApplicationForm implements ProfileSideEffect {
  const ProfileSideEffect$NavToWorkerApplicationForm();
}

class ProfileSideEffect$NavToUpdateUserInfo implements ProfileSideEffect {
  const ProfileSideEffect$NavToUpdateUserInfo();
}

class ProfileSideEffect$NavToUpdateBusinessInfo implements ProfileSideEffect {
  const ProfileSideEffect$NavToUpdateBusinessInfo();
}

class ProfileSideEffect$NavToProfileImagePicker implements ProfileSideEffect {
  const ProfileSideEffect$NavToProfileImagePicker();
}

class ProfileSideEffect$NavToVehicleImagePicker implements ProfileSideEffect {
  const ProfileSideEffect$NavToVehicleImagePicker();
}

class ProfileSideEffect$NavToSavedCards implements ProfileSideEffect {
  const ProfileSideEffect$NavToSavedCards();
}

class ProfileSideEffect$NavToNotificationSettings implements ProfileSideEffect {
  const ProfileSideEffect$NavToNotificationSettings();
}

