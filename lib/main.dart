import 'package:auth_app/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'blocs/login_bloc/login_form_bloc.dart';
import 'blocs/register_bloc/register_form_bloc.dart';
import 'blocs/user_bloc/user_bloc.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authRepositority = AuthRepository(FirebaseAuth.instance);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            authRepositority,
          ),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authRepositority,
          ),
        ),
        BlocProvider(
          create: (context) => LoginFormBloc(
            authRepositority,
          ),
        ),
        BlocProvider(
          create: (context) => RegisterFormBloc(
            authRepositority,
          ),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(
            authRepositority,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        theme: ThemeData(
          accentColor: Colors.white,
          backgroundColor: Colors.black,
          primaryColor: Colors.green,
          hintColor: Colors.grey[600],
          hoverColor: Colors.grey[900],
          textTheme: TextTheme(
            headline5: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
            headline6: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 36,
            ),
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
