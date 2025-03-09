import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const AuthButton({
    Key? key,
    required this.onPressed,
    required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 10, horizontal: 53)),
        backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF252EFF)),
      ),
      child: Text(label),
    );
  }
}
