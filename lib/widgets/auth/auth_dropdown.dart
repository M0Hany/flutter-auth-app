import 'dart:ffi';

import 'package:flutter/material.dart';

class AuthDropdown extends StatelessWidget {
  final String? label;
  final String? hintText;
  final List<String> items;
  final Function(String) onChanged;
  const AuthDropdown({
    super.key,
    required this.onChanged,
    required this.items,
    this.label,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: null,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFF252EFF), width: 2.0)
        ),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFF252EFF), width: 2.0)
        ),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFFed4337), width: 2.0)
        ),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFFed4337), width: 2.0)
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(
        value: item,
        child: Text("$label $item"),
      ))
          .toList(),
      onChanged: (newValue) {
        onChanged;
      }
    );
  }
}
