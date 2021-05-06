import 'package:auth_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseInitialization {
  static Future<void> initializeFirebase(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<AuthenticationBloc>().add(
            AuthenticationSignedIn(user: user),
          );
    } else {
      context.read<AuthenticationBloc>().add(
            AuthenticationSignedOut(),
          );
    }
  }
}
