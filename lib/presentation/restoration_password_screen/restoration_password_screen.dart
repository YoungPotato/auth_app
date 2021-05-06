import 'package:flutter/material.dart';

import 'components/restoration_password_body.dart';

class RestorationPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: RestorationPasswordBody(),
        ),
      ),
    );
  }
}
