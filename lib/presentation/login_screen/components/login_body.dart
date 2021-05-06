import 'package:auth_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:auth_app/blocs/login_bloc/login_form_bloc.dart';
import 'package:auth_app/constants/string_constants.dart';
import 'package:auth_app/presentation/components/google_sign_in.dart';
import 'package:auth_app/presentation/components/snackBar.dart';
import 'package:auth_app/presentation/components/submit_button.dart';
import 'package:auth_app/presentation/components/text_field.dart';
import 'package:auth_app/presentation/components/text_hint.dart';
import 'package:auth_app/presentation/register_screen/register_screen.dart';
import 'package:auth_app/utils/text_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBody extends StatefulWidget {
  LoginBody({Key key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  LoginFormBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = context.read<LoginFormBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<LoginFormBloc, LoginFormState>(
        listener: (context, state) {
      if (state.isLoading) {
        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: SnackBarContent(
                text: StringConstants.loading,
              ),
            ),
          );
      } else if (state.isFailureLogin) {
        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: theme.errorColor,
              content: SnackBarContent(
                text: StringConstants.failure,
              ),
            ),
          );
      } else if (state.user != null) {
        context.read<AuthenticationBloc>().add(
              AuthenticationSignedIn(user: state.user),
            );
      }
    }, builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConstants.letSignIn,
            style: theme.textTheme.headline5,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            StringConstants.welcomeBack,
            style: theme.textTheme.headline6,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            StringConstants.youHaveBeenMissed,
            style: theme.textTheme.headline6,
          ),
          SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoogleSignIn(
                onPressed: () => _onLoginWithGoogleAccountButtonPressed(),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              StringConstants.orLoginWithEmail,
              style: theme.textTheme.bodyText2.copyWith(
                color: theme.hintColor,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFieldForm(
            textController: _emailController,
            validatorText: ValidatorText.getValidatorText(state.emailStatus),
            isPassword: false,
            icon: Icons.alternate_email,
            hintText: StringConstants.email,
            onTextChanged: () => _onEmailChanged(),
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldForm(
            haveForgot: true,
            textController: _passwordController,
            validatorText: ValidatorText.getValidatorText(state.passwordStatus),
            isPassword: true,
            icon: Icons.lock_outline_rounded,
            hintText: StringConstants.password,
            onTextChanged: () => _onPasswordChanged(),
          ),
          Spacer(),
          TextHint(
            onTap: () => _onTextHintPressed(context),
            text: StringConstants.dontHaveAccount,
            buttonText: StringConstants.register,
          ),
          SizedBox(
            height: 30,
          ),
          SubmitButton(
            color: state.isButtonActive ? theme.accentColor : theme.hoverColor,
            buttonText: StringConstants.signIn,
            onPressed: () => state.isButtonActive ? _onButtonPressed() : null,
          ),
        ],
      );
    });
  }

  void _onEmailChanged() => _loginBloc.add(
        LoginFormEmailChanged(email: _emailController.text),
      );

  void _onPasswordChanged() => _loginBloc.add(
        LoginFormPasswordChanged(password: _passwordController.text),
      );

  void _onButtonPressed() => _loginBloc.add(
        LoginFormSubmitButtomPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );

  void _onLoginWithGoogleAccountButtonPressed() => _loginBloc.add(
        LoginWithGoogleAccount(),
      );

  void _onTextHintPressed(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        ),
      );
}
