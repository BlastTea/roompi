part of '../blocs.dart';

@immutable
abstract class AuthenticationEvent {}

class SetAuthenticationState extends AuthenticationEvent {
  SetAuthenticationState([this.state]);

  final AuthenticationState? state;
}

class SetSignInPasswordVisible extends AuthenticationEvent {
  SetSignInPasswordVisible({required this.value});

  final bool value;
}

class SetSignUpPasswordVisible extends AuthenticationEvent {
  SetSignUpPasswordVisible({required this.value});

  final bool value;
}

class SetSignUpPasswordConfirmationVisible extends AuthenticationEvent {
  SetSignUpPasswordConfirmationVisible({required this.value});

  final bool value;
}

class SignInPressed extends AuthenticationEvent {}

class SignUpPressed extends AuthenticationEvent {
  SignUpPressed({
    required this.role,
    this.activityType,
    this.equalityPackageType,
  });

  final UserRole role;
  final ActivityType? activityType;
  final EqualityPackageType? equalityPackageType;
}
