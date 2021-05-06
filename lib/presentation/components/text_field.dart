import 'package:auth_app/presentation/components/widgets/forgot_password.dart';
import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  const TextFieldForm({
    Key key,
    @required this.hintText,
    @required this.onTextChanged,
    @required this.icon,
    this.isPassword = false,
    @required this.validatorText,
    this.textController,
    this.haveForgot = false,
  }) : super(key: key);

  final hintText;
  final onTextChanged;
  final icon;
  final isPassword;
  final validatorText;
  final textController;
  final haveForgot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: textController,
        autovalidateMode: AutovalidateMode.always,
        validator: (_) => validatorText,
        obscureText: isPassword ? true : false,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        onChanged: (_) => onTextChanged(),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Theme.of(context).accentColor),
          suffix: !haveForgot ? null : ForgotPasswordWidget(),
          hintText: hintText,
          hintStyle: TextStyle(color: theme.hintColor),
          fillColor: Colors.white,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
