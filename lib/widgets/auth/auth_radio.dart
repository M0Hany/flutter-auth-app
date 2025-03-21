import 'package:flutter/material.dart';

class AuthRadio extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final Function(String) onChanged;

  const AuthRadio({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          activeColor: Color(0xFF252EFF),
        ),
        Text(title, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
