import 'package:auth_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/home_body.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: theme.accentColor,
            ),
            onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationSignedOut(),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: HomeBody(user: user),
        ),
      ),
    );
  }
}
