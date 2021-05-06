import 'dart:async';

import 'package:auth_app/domain/intefaces/auth_base_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthBaseRepository _authRepository;
  AuthenticationBloc(this._authRepository) : super(FirebaseInit());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationSignedIn) {
      yield* _mapSighInToState(event.user);
    } else if (event is AuthenticationSignedOut) {
      yield* _mapSighInOutState();
    }
  }

  Stream<AuthenticationState> _mapSighInToState(User user) async* {
    yield Authtorized(user: user);
  }

  Stream<AuthenticationState> _mapSighInOutState() async* {
    await _authRepository.signOut();
    yield NotAuthtorized();
  }
}
