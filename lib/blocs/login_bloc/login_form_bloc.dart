import 'dart:async';

import 'package:auth_app/domain/models/field_status.dart';
import 'package:auth_app/domain/intefaces/auth_base_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthBaseRepository _authRepository;
  LoginFormBloc(this._authRepository) : super(LoginFormState.initial());

  @override
  Stream<LoginFormState> mapEventToState(
    LoginFormEvent event,
  ) async* {
    if (event is LoginFormEmailChanged) {
      yield* _mapLoginEmailChangeToState(
        event.email,
      );
    } else if (event is LoginFormPasswordChanged) {
      yield* _mapLoginPasswordChangeToState(
        event.password,
      );
    } else if (event is LoginFormSubmitButtomPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is LoginWithGoogleAccount) {
      yield* _mapLoginWithGoogleAccountPressedToState();
    }
  }

  Stream<LoginFormState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(
      emailStatus: email.isEmpty ? FieldStatus.invalid : FieldStatus.valid,
    );
  }

  Stream<LoginFormState> _mapLoginPasswordChangeToState(
      String password) async* {
    yield state.update(
      passwordStatus:
          password.isEmpty ? FieldStatus.invalid : FieldStatus.valid,
    );
  }

  Stream<LoginFormState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginFormState.loading();
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      yield LoginFormState.successLogin(_authRepository.user);
    } catch (_) {
      yield LoginFormState.failureLogin();
    }
  }

  Stream<LoginFormState> _mapLoginWithGoogleAccountPressedToState() async* {
    try {
      await _authRepository.signInWithGoogle();
      if (_authRepository.user != null) {
        yield LoginFormState.successLogin(_authRepository.user);
      }
    } catch (_) {
      yield LoginFormState.failureLogin();
    }
  }
}
