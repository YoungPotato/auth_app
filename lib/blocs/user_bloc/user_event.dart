part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UpdatePasswordSubmitButtonPressed extends UserEvent {
  final String newPassword;

  UpdatePasswordSubmitButtonPressed({
    @required this.newPassword,
  });
}

class UserPasswordChanged extends UserEvent {
  final String newPassword;

  UserPasswordChanged({
    @required this.newPassword,
  });
}
