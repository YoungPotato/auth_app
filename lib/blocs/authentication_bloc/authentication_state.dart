part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class FirebaseInit extends AuthenticationState {}

class NotAuthtorized extends AuthenticationState {}

class Authtorized extends AuthenticationState {
  final User user;

  Authtorized({
    @required this.user,
  });
}
