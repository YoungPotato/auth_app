import 'package:auth_app/constants/string_constants.dart';
import 'package:auth_app/presentation/restoration_password_screen/restoration_password_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RestorationPasswordScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          StringConstants.forgot,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
