import 'package:auth_app/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:auth_app/constants/string_constants.dart';
import 'package:auth_app/presentation/components/snackBar.dart';
import 'package:auth_app/presentation/components/submit_button.dart';
import 'package:auth_app/presentation/components/text_field.dart';
import 'package:auth_app/utils/text_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestorationPasswordBody extends StatefulWidget {
  RestorationPasswordBody({Key key}) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RestorationPasswordBody> {
  final _emailController = TextEditingController();
  ForgotPasswordBloc _forgotPasswordBloc;

  @override
  void initState() {
    _forgotPasswordBloc = context.read<ForgotPasswordBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
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
      } else if (state.isFailureSendEmail) {
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
      } else if (state.isSuccess) {
        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: theme.primaryColor,
              content: SnackBarContent(
                text: StringConstants.sentEmailText,
              ),
            ),
          );
      }
    }, builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConstants.resetPassword,
            style: theme.textTheme.headline5,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            StringConstants.restorationPasswordText,
            style: theme.textTheme.bodyText1,
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
          Spacer(),
          SizedBox(
            height: 30,
          ),
          SubmitButton(
            color: state.isButtonActive ? theme.accentColor : theme.hoverColor,
            buttonText: StringConstants.sendEmail,
            onPressed: () => state.isButtonActive ? _onButtonPressed() : null,
          ),
        ],
      );
    });
  }

  void _onEmailChanged() => _forgotPasswordBloc.add(
        ForgotPasswordEmailChanged(email: _emailController.text),
      );

  void _onButtonPressed() => _forgotPasswordBloc.add(
        ForgotPasswordSubmitButtonPressed(
          email: _emailController.text,
        ),
      );
}
