import 'package:auth_app/blocs/register_bloc/register_form_bloc.dart';
import 'package:auth_app/constants/string_constants.dart';
import 'package:auth_app/presentation/components/snackBar.dart';
import 'package:auth_app/presentation/components/submit_button.dart';
import 'package:auth_app/presentation/components/text_field.dart';
import 'package:auth_app/presentation/components/text_hint.dart';
import 'package:auth_app/utils/text_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBody extends StatefulWidget {
  RegisterBody({Key key}) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  RegisterFormBloc _registerBloc;

  @override
  void initState() {
    _registerBloc = context.read<RegisterFormBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<RegisterFormBloc, RegisterFormState>(
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
      } else if (state.isFailureRegister) {
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
      } else if (state.isSuccessRegister) {
        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: theme.primaryColor,
              content: SnackBarContent(
                text: StringConstants.registrationCompletedSuccessfully,
              ),
            ),
          );
      }
    }, builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConstants.newHere,
            style: theme.textTheme.headline5,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            StringConstants.dontWorry,
            style: theme.textTheme.headline6,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            StringConstants.registerText,
            style: theme.textTheme.headline6,
          ),
          SizedBox(
            height: 80,
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
            textController: _passwordController,
            validatorText: ValidatorText.getValidatorText(state.passwordStatus),
            isPassword: true,
            icon: Icons.lock_outline_rounded,
            hintText: StringConstants.password,
            onTextChanged: () => _onPasswordChanged(),
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldForm(
            textController: _confirmedPasswordController,
            validatorText:
                ValidatorText.getValidatorText(state.confirmedPasswordStatus),
            isPassword: true,
            icon: Icons.lock_outline_rounded,
            hintText: StringConstants.confirmPassword,
            onTextChanged: () => _onConfirmedPasswordChanged(),
          ),
          Spacer(),
          TextHint(
            onTap: () => _onTextHintPressed(context),
            text: StringConstants.alreadyHaveAccount,
            buttonText: StringConstants.login,
          ),
          SizedBox(
            height: 30,
          ),
          SubmitButton(
            color: state.isButtonActive ? theme.accentColor : theme.hoverColor,
            buttonText: StringConstants.signUp,
            onPressed: () => state.isButtonActive ? _onButtonPressed() : null,
          ),
        ],
      );
    });
  }

  void _onEmailChanged() => _registerBloc.add(
        RegisterFormEmailChanged(email: _emailController.text),
      );

  void _onPasswordChanged() => _registerBloc.add(
        RegisterFormPasswordChanged(password: _passwordController.text),
      );

  void _onConfirmedPasswordChanged() => _registerBloc.add(
        RegisterFormConfirmedPasswordChanged(
          confirmedPassword: _confirmedPasswordController.text,
          password: _passwordController.text,
        ),
      );

  void _onButtonPressed() => _registerBloc.add(
        RegisterFormSubmitButtomPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );

  void _onTextHintPressed(BuildContext context) => Navigator.pop(context);
}
