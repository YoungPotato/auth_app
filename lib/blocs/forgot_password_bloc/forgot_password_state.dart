part of 'forgot_password_bloc.dart';

class ForgotPasswordState {
  final FieldStatus emailStatus;
  final bool isButtonActive;
  final bool isFailureSendEmail;
  final bool isLoading;
  final bool isSuccess;

  ForgotPasswordState({
    this.emailStatus = FieldStatus.valid,
    this.isSuccess = false,
    this.isLoading = false,
    this.isFailureSendEmail = false,
  }) : isButtonActive = emailStatus == FieldStatus.valid && !isLoading;

  factory ForgotPasswordState.initial() => ForgotPasswordState(
        emailStatus: FieldStatus.initial,
      );

  factory ForgotPasswordState.loading() => ForgotPasswordState(
        isLoading: true,
      );

  factory ForgotPasswordState.failureSendEmail() => ForgotPasswordState(
        isFailureSendEmail: true,
      );

  factory ForgotPasswordState.successSendEmail() => ForgotPasswordState(
        isSuccess: true,
      );
}

extension UpdateForgotPasswordState on ForgotPasswordState {
  ForgotPasswordState update({
    FieldStatus emailStatus,
    FieldStatus passwordStatus,
  }) {
    return ForgotPasswordState(
      emailStatus: emailStatus ?? this.emailStatus,
    );
  }
}
