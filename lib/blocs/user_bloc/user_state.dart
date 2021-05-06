part of 'user_bloc.dart';

class UserState {
  final FieldStatus passwordStatus;
  final bool isButtonActive;
  final bool isFailureUpdatePassword;
  final bool isLoading;
  final bool isSuccess;

  UserState({
    this.passwordStatus = FieldStatus.valid,
    this.isSuccess = false,
    this.isLoading = false,
    this.isFailureUpdatePassword = false,
  }) : isButtonActive = passwordStatus == FieldStatus.valid && !isLoading;

  factory UserState.initial() => UserState(
        passwordStatus: FieldStatus.initial,
      );

  factory UserState.loading() => UserState(
        isLoading: true,
      );

  factory UserState.failureSendEmail() => UserState(
        isFailureUpdatePassword: true,
      );

  factory UserState.successUpdatePassword() => UserState(
        isSuccess: true,
      );
}

extension UpdateUserStateState on UserState {
  UserState update({
    FieldStatus passwordStatus,
  }) {
    return UserState(
      passwordStatus: passwordStatus ?? this.passwordStatus,
    );
  }
}
