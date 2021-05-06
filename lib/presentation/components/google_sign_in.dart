import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleSignIn extends StatelessWidget {
  final onPressed;

  const GoogleSignIn({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.accentColor,
        ),
        child: SvgPicture.asset('assets/logos/google_logo.svg'),
      ),
    );
  }
}
