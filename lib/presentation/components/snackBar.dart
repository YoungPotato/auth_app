import 'package:flutter/material.dart';

class SnackBarContent extends StatelessWidget {
  final String text;
  const SnackBarContent({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
