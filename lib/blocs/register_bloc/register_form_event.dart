part of 'register_form_bloc.dart';

@immutable
abstract class RegisterFormEvent {}

class RegisterFormEmailChanged extends RegisterFormEvent {
  final email;

  RegisterFormEmailChanged({
    @required this.email,
  });
}

class RegisterFormPasswordChanged extends RegisterFormEvent {
  final password;

  RegisterFormPasswordChanged({
    @required this.password,
  });
}

class RegisterFormConfirmedPasswordChanged extends RegisterFormEvent {
  final password;
  final confirmedPassword;

  RegisterFormConfirmedPasswordChanged({
    @required this.confirmedPassword,
    @required this.password,
  });
}

class RegisterFormSubmitButtomPressed extends RegisterFormEvent {
  final String email;
  final String password;

  RegisterFormSubmitButtomPressed({
    @required this.email,
    @required this.password,
  });
}

class LoginWithGoogleAccount extends RegisterFormEvent {}
