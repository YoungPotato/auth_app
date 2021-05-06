part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordEmailChanged({
    @required this.email,
  });
}

class ForgotPasswordSubmitButtonPressed extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordSubmitButtonPressed({
    @required this.email,
  });
}
