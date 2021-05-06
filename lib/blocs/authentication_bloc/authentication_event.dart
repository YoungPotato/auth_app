part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationSignedIn extends AuthenticationEvent {
  final User user;

  AuthenticationSignedIn({
    @required this.user,
  });
}

class AuthenticationSignedOut extends AuthenticationEvent {}
