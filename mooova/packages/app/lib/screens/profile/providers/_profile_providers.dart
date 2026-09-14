import 'dart:async';

import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../di/di.dart';
import '../../../../models/types/user_role_type.dart';
import '../../../../models/user_model.dart';
import '../../../../repositories/upload/upload_repository.dart';
import '../../../../repositories/user/user_repository.dart';
import '../../../../core/ext/riverpod_ext.dart';
import '../widgets/modal/profile_update_business_info_modal_content.dart';
import '../widgets/modal/profile_update_user_info_modal_content.dart';

part 'profile_business_info_providers.dart';

part 'profile_selected_tab_providers.dart';

part 'profile_side_effects_providers.dart';

part 'profile_state_providers.dart';

part 'profile_user_info_providers.dart';

part 'profile_worker_info_providers.dart';

const _name = 'Profile';

final _scope = ProviderScopeContainer();

final userRepositoryProvider = Provider((ref) => Di.userRepository);

final userWorkerRepositoryProvider = Provider((ref) => Di.userWorkerRepository);

final uploadRepositoryProvider = Provider((ref) => Di.uploadRepository);

final authRepositoryProvider = Provider((ref) => Di.authRepository);

final profileProvider = StreamNotifierProvider<ProfileNotifier, UserModel>(
  name: '$_name.ProfileProvider',
  dependencies: _scope.dependencies,
  () => ProfileNotifier(),
).scoped(_scope);

class ProfileNotifier extends StreamNotifier<UserModel> {
  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _authRepository = () => ref.read(authRepositoryProvider);

  @override
  Stream<UserModel> build() async* {
    final userRepository = ref.watch(userRepositoryProvider);
    final startWithUserResult = await userRepository.getUserOrNull();
    final stream = userRepository.onUserChanged.cast<UserModel?>().startWith(startWithUserResult.asValue!.value);

    await for (final user in stream) {
      if (user != null) {
        yield user;
      } else {
        state = const AsyncValue.loading();
      }
    }
  }

  void onLogoutClicked() async {
    await _authRepository().signOut();
    _sideEffect().add(const ProfileSideEffect$NavToHome());
  }

  void onShareClicked() async {}

  void onImageShareClicked() async {}

  void onOpenSavedCardClicked() async {
    _sideEffect().add(const ProfileSideEffect$NavToSavedCards());
  }

  void onOpenNotificationSettingsClicked() async {
    _sideEffect().add(const ProfileSideEffect$NavToNotificationSettings());
  }
}
