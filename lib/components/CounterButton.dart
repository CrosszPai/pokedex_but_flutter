import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CounterButton({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      color: Colors.transparent,
      child: Text(text),
      highlightColor: Colors.transparent,
    );
  }
}
