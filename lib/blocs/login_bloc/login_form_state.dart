part of 'login_form_bloc.dart';

class LoginFormState {
  final FieldStatus emailStatus;
  final FieldStatus passwordStatus;
  final bool isButtonActive;
  final bool isFailureLogin;
  final bool isLoading;
  final User user;

  LoginFormState({
    this.user,
    this.emailStatus = FieldStatus.valid,
    this.passwordStatus = FieldStatus.valid,
    this.isLoading = false,
    this.isFailureLogin = false,
  }) : isButtonActive = emailStatus == FieldStatus.valid &&
            passwordStatus == FieldStatus.valid &&
            !isLoading;

  factory LoginFormState.initial() => LoginFormState(
        emailStatus: FieldStatus.initial,
        passwordStatus: FieldStatus.initial,
      );

  factory LoginFormState.loading() => LoginFormState(
        isLoading: true,
      );

  factory LoginFormState.failureLogin() => LoginFormState(
        isFailureLogin: true,
      );

  factory LoginFormState.successLogin(User user) => LoginFormState(
        user: user,
      );
}

extension UpdateLoginFormState on LoginFormState {
  LoginFormState update({
    FieldStatus emailStatus,
    FieldStatus passwordStatus,
  }) {
    return LoginFormState(
      emailStatus: emailStatus ?? this.emailStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
    );
  }
}
