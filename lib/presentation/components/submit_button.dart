import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key key,
    @required this.buttonText,
    @required this.onPressed,
    @required this.color,
  }) : super(key: key);

  final buttonText;
  final onPressed;
  final color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              buttonText,
              style: theme.textTheme.bodyText2,
            ),
          ),
        ),
      ),
    );
  }
}
