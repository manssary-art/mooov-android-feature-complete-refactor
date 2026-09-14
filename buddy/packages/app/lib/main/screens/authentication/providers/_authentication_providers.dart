import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/di.dart';
import '../../../../repositories/user/user_repository.dart';
import '../../../core/riverpod_ext.dart';
import '../models/auth_step.dart';
import '../models/phone_auth_request.dart';

part 'authentication_country_providers.dart';

part 'authentication_side_effects_providers.dart';

part 'authentication_state_providers.dart';

const _name = 'Authentication';

final _scope = ProviderScopeContainer();

final signInRepositoryProvider = Provider((ref) => Di.signInRepository);

final authRepositoryProvider = Provider((ref) => Di.authRepository);

final userRepositoryProvider = Provider((ref) => Di.userRepository);

final authenticationProvider =
    NotifierProvider.autoDispose<AuthenticationNotifier, AuthStep>(
  name: '$_name.authenticationProvider',
  dependencies: _scope.dependencies,
  () => AuthenticationNotifier(),
).scoped(_scope);

class AuthenticationNotifier extends AutoDisposeNotifier<AuthStep> {
  PhoneAuthenticationRequest? _phoneAuthenticationRequest;

  late final _userRepository = () => ref.read(userRepositoryProvider);
  late final _signInRepository = () => ref.read(signInRepositoryProvider);
  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _phoneNumber = () => ref.read(phoneNumberProvider);
  late final _verificationCode = () => ref.read(verificationCodeProvider);
  late final _country = () => ref.read(countryProvider);
  late final _firstNameNotifier = () => ref.read(firstNameProvider.notifier);
  late final _lastNameNotifier = () => ref.read(lastNameProvider.notifier);
  late final _emailNotifier = () => ref.read(emailProvider.notifier);
  late final _isWorkingNotifier = () => ref.read(isWorkingProvider.notifier);

  @override
  AuthStep build() {
    ref.onDispose(_onDispose);
    return AuthStep.enterPhoneNumber;
  }

  void _onDispose() async {
    if (state != AuthStep.done) {
      await ref.read(authRepositoryProvider).signOut();
    }
  }

  void onNavBackClicked() async {
    if (_isWorkingNotifier().state) return;
    _sideEffect().add(const AuthenticationSideEffect$NavBack());
  }

  void onSendCodeClicked() async {
    try {
      _isWorkingNotifier().state = true;
      final phoneNumber = _phoneNumber();
      final country = _country();
      await _signInRepository()
          .startSignInWithPhone(
            phoneNumber: phoneNumber,
            country: country,
          )
          .mapValue(
            (value) => PhoneAuthenticationRequest(
              phoneNumber: phoneNumber,
              country: country,
              credential: value,
            ),
          )
          .onValue((value) {
        state = AuthStep.enterVerificationCode;
        _phoneAuthenticationRequest = value;
      });
    } finally {
      _isWorkingNotifier().state = false;
    }
  }

  void onSubmitCodeClicked() async {
    try {
      _isWorkingNotifier().state = true;
      final phoneAuthenticationRequest = _phoneAuthenticationRequest;
      if (phoneAuthenticationRequest == null) return;

      await _signInRepository()
          .completeSignInWithPhone(
            smsCode: _verificationCode(),
            credential: phoneAuthenticationRequest.credential,
          )
          .flatMapValue((_) => _userRepository().getUserOrNull())
          .flatMapError((e, s) => Result.value(null))
          .onValue((e) {
        if (e != null &&
            e.firstName?.isNotEmpty == true &&
            e.lastName?.isNotEmpty == true) {
          state = AuthStep.done;
          _sideEffect().add(const AuthenticationSideEffect$NavBack());
        } else {
          _firstNameNotifier().state =
              e?.firstName ?? _firstNameNotifier().state;
          _lastNameNotifier().state = e?.lastName ?? _lastNameNotifier().state;
          _emailNotifier().state = e?.email ?? _emailNotifier().state;
          state = AuthStep.enterInfo;
        }
      });
    } finally {
      _isWorkingNotifier().state = false;
    }
  }

  void onSubmitInfoClicked() async {
    try {
      _isWorkingNotifier().state = true;
      final phoneAuthenticationRequest = _phoneAuthenticationRequest;
      if (phoneAuthenticationRequest == null) return;
      final firstName = _firstNameNotifier().state;
      final lastName = _lastNameNotifier().state;
      final email = _emailNotifier().state;
      final phoneNumber = phoneAuthenticationRequest.phoneNumber;
      final country = phoneAuthenticationRequest.country;
      await _userRepository()
          .createUser(
            firstName: firstName,
            lastName: lastName,
            country: country,
            phoneNumber: phoneNumber,
            email: email,
          )
          .onValue((e) => state = AuthStep.done)
          .onValue((e) =>
              _sideEffect().add(const AuthenticationSideEffect$NavBack()));
    } finally {
      _isWorkingNotifier().state = false;
    }
  }
}
