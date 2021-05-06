import 'dart:async';

import 'package:auth_app/domain/models/field_status.dart';
import 'package:auth_app/domain/intefaces/auth_base_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthBaseRepository _authRepository;
  ForgotPasswordBloc(this._authRepository)
      : super(ForgotPasswordState.initial());

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is ForgotPasswordEmailChanged) {
      yield* _mapForgotPasswordEmailChangeToState(
        event.email,
      );
    } else if (event is ForgotPasswordSubmitButtonPressed) {
      yield* _mapForgotPasswordSubmitButtonToState(
        email: event.email,
      );
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordEmailChangeToState(
      String email) async* {
    yield state.update(
      emailStatus: email.isEmpty ? FieldStatus.invalid : FieldStatus.valid,
    );
  }

  Stream<ForgotPasswordState> _mapForgotPasswordSubmitButtonToState({
    String email,
  }) async* {
    yield ForgotPasswordState.loading();
    try {
      await _authRepository.sendPasswordResetEmail(email);
      yield ForgotPasswordState.successSendEmail();
    } catch (_) {
      yield ForgotPasswordState.failureSendEmail();
    }
  }
}
