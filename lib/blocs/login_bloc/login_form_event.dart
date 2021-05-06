part of 'login_form_bloc.dart';

@immutable
abstract class LoginFormEvent {}

class LoginFormEmailChanged extends LoginFormEvent {
  final String email;

  LoginFormEmailChanged({
    @required this.email,
  });
}

class LoginFormPasswordChanged extends LoginFormEvent {
  final String password;

  LoginFormPasswordChanged({
    @required this.password,
  });
}

class LoginFormSubmitButtomPressed extends LoginFormEvent {
  final String email;
  final String password;

  LoginFormSubmitButtomPressed({
    @required this.email,
    @required this.password,
  });
}

class LoginWithGoogleAccount extends LoginFormEvent {}
