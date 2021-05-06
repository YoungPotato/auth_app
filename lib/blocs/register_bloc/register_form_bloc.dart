import 'dart:async';

import 'package:auth_app/domain/models/field_status.dart';
import 'package:auth_app/domain/intefaces/auth_base_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  final AuthBaseRepository _authRepository;

  RegisterFormBloc(this._authRepository) : super(RegisterFormState.initial());

  @override
  Stream<RegisterFormState> mapEventToState(
    RegisterFormEvent event,
  ) async* {
    if (event is RegisterFormEmailChanged) {
      yield* _mapLoginEmailChangeToState(
        event.email,
      );
    } else if (event is RegisterFormPasswordChanged) {
      yield* _mapLoginPasswordChangeToState(
        event.password,
      );
    } else if (event is RegisterFormConfirmedPasswordChanged) {
      yield* _mapLoginConfirmedPasswordChangeToState(
        event.password,
        event.confirmedPassword,
      );
    } else if (event is RegisterFormSubmitButtomPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is LoginWithGoogleAccount) {
      yield* _mapLoginWithGoogleAccountPressedToState();
    }
  }

  Stream<RegisterFormState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(
      emailStatus: email.isEmpty ? FieldStatus.invalid : FieldStatus.valid,
    );
  }

  Stream<RegisterFormState> _mapLoginPasswordChangeToState(
      String password) async* {
    yield state.update(
      passwordStatus:
          password.isEmpty ? FieldStatus.invalid : FieldStatus.valid,
    );
  }

  Stream<RegisterFormState> _mapLoginConfirmedPasswordChangeToState(
    String password,
    String confirmedPassword,
  ) async* {
    yield state.update(
      confirmedPasswordStatus: password == confirmedPassword
          ? FieldStatus.valid
          : FieldStatus.invalid,
    );
  }

  Stream<RegisterFormState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield RegisterFormState.loading();
    try {
      await _authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _authRepository.signOut();
      yield RegisterFormState.successRegister();
    } catch (_) {
      yield RegisterFormState.failureRegister();
    }
  }

  Stream<RegisterFormState> _mapLoginWithGoogleAccountPressedToState() async* {
    try {
      await _authRepository.signInWithGoogle();
      if (_authRepository.user != null)
        yield RegisterFormState.successRegister();
    } catch (_) {
      yield RegisterFormState.failureRegister();
    }
  }
}
