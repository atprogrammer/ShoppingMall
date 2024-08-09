import 'package:flutter/material.dart';

class ShowTitle extends StatelessWidget {
  final String title;
  final TextStyle testStyle;
  const ShowTitle({
    super.key,
    required this.title,
    required this.testStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: testStyle,
    );
  }
}
