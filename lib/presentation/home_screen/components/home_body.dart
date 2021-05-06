import 'package:auth_app/blocs/user_bloc/user_bloc.dart';
import 'package:auth_app/constants/string_constants.dart';
import 'package:auth_app/presentation/components/snackBar.dart';
import 'package:auth_app/presentation/components/submit_button.dart';
import 'package:auth_app/presentation/components/text_field.dart';
import 'package:auth_app/utils/text_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  final User user;
  HomeBody({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeBody> {
  final _passwordController = TextEditingController();
  UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<UserBloc, UserState>(
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
        } else if (state.isFailureUpdatePassword) {
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
                  text: StringConstants.passwordUpdatedSuccessfuly,
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConstants.createNewPassword,
              style: theme.textTheme.headline5,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              StringConstants.homeText,
              style: theme.textTheme.bodyText1,
            ),
            SizedBox(
              height: 80,
            ),
            TextFieldForm(
              textController: _passwordController,
              validatorText:
                  ValidatorText.getValidatorText(state.passwordStatus),
              isPassword: true,
              icon: Icons.lock_outline_rounded,
              hintText: StringConstants.newPassword,
              onTextChanged: () => _onPasswordChanged(),
            ),
            Spacer(),
            SizedBox(
              height: 30,
            ),
            SubmitButton(
              color:
                  state.isButtonActive ? theme.accentColor : theme.hoverColor,
              buttonText: StringConstants.updatePassword,
              onPressed: () => state.isButtonActive ? _onButtonPressed() : null,
            ),
          ],
        );
      },
    );
  }

  void _onPasswordChanged() => _userBloc.add(
        UserPasswordChanged(
          newPassword: _passwordController.text,
        ),
      );

  void _onButtonPressed() => _userBloc.add(
        UpdatePasswordSubmitButtonPressed(
          newPassword: _passwordController.text,
        ),
      );
}
