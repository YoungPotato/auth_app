part of 'register_form_bloc.dart';

class RegisterFormState {
  final FieldStatus emailStatus;
  final FieldStatus passwordStatus;
  final FieldStatus confirmedPasswordStatus;
  final bool isButtonActive;
  final bool isFailureRegister;
  final bool isLoading;
  final bool isSuccessRegister;

  RegisterFormState({
    this.emailStatus = FieldStatus.valid,
    this.passwordStatus = FieldStatus.valid,
    this.confirmedPasswordStatus = FieldStatus.valid,
    this.isFailureRegister = false,
    this.isLoading = false,
    this.isSuccessRegister = false,
  }) : isButtonActive = emailStatus == FieldStatus.valid &&
            passwordStatus == FieldStatus.valid &&
            confirmedPasswordStatus == FieldStatus.valid &&
            !isLoading;

  factory RegisterFormState.initial() => RegisterFormState(
        emailStatus: FieldStatus.initial,
        passwordStatus: FieldStatus.initial,
        confirmedPasswordStatus: FieldStatus.initial,
      );

  factory RegisterFormState.loading() => RegisterFormState(
        isLoading: true,
      );

  factory RegisterFormState.failureRegister() => RegisterFormState(
        isFailureRegister: true,
      );

  factory RegisterFormState.successRegister() => RegisterFormState(
        isSuccessRegister: true,
      );
}

extension UpdateRegisterFormState on RegisterFormState {
  RegisterFormState update({
    FieldStatus emailStatus,
    FieldStatus passwordStatus,
    FieldStatus confirmedPasswordStatus,
  }) {
    return RegisterFormState(
      emailStatus: emailStatus ?? this.emailStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      confirmedPasswordStatus:
          confirmedPasswordStatus ?? this.confirmedPasswordStatus,
    );
  }
}
