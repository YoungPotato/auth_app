import 'dart:async';

import 'package:auth_app/domain/models/field_status.dart';
import 'package:auth_app/domain/intefaces/auth_base_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthBaseRepository _authRepository;
  UserBloc(this._authRepository) : super(UserState.initial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserPasswordChanged) {
      yield* _mapPasswordChangeToState(
        event.newPassword,
      );
    } else if (event is UpdatePasswordSubmitButtonPressed) {
      yield* _mapUpdatePasswordSubmitButtonToState(
        newPassword: event.newPassword,
      );
    }
  }

  Stream<UserState> _mapPasswordChangeToState(String password) async* {
    yield state.update(
      passwordStatus:
          password.isEmpty ? FieldStatus.invalid : FieldStatus.valid,
    );
  }

  Stream<UserState> _mapUpdatePasswordSubmitButtonToState({
    String newPassword,
  }) async* {
    yield UserState.loading();
    try {
      await _authRepository.updatePassword(newPassword);
      yield UserState.successUpdatePassword();
    } catch (_) {
      yield UserState.failureSendEmail();
    }
  }
}
