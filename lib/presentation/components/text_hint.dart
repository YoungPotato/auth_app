import 'package:flutter/material.dart';

class TextHint extends StatelessWidget {
  final Function() onTap;
  final String text;
  final String buttonText;
  const TextHint({
    Key key,
    @required this.onTap,
    @required this.text,
    @required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
            style: theme.textTheme.bodyText2.copyWith(
              color: theme.hintColor,
              fontSize: 14,
            )),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
