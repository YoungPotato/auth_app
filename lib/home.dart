import 'package:auth_app/presentation/home_screen/home_screen.dart';
import 'package:auth_app/presentation/login_screen/login_screen.dart';
import 'package:auth_app/presentation/splash_screen.dart';
import 'package:auth_app/utils/firebase_initialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseInitialization.initializeFirebase(context);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is FirebaseInit) {
        return SplashScreen();
      } else if (state is Authtorized) {
        return HomeScreen(user: state.user);
      } else if (state is NotAuthtorized) {
        return LoginScreen();
      }
    });
  }
}
