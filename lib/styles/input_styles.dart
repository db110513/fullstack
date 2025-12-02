import 'package:flutter/material.dart';

class InputStyles {
  static const BorderSide _borderBlanc54 = BorderSide(
    color: Colors.white54,
    width: 1.5
  );

  static const BorderSide _borderBlancFocus = BorderSide(
    color: Colors.white,
    width: 2
  );

  static OutlineInputBorder get enabledBorder => OutlineInputBorder(
    borderSide: _borderBlanc54,
  );

  static OutlineInputBorder get focusedBorder => OutlineInputBorder(
    borderSide: _borderBlancFocus,
  );

  static InputDecoration textFieldDecoration({
    required String labelText,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,
      border: OutlineInputBorder(),
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: const TextStyle(color: Colors.white70),
      floatingLabelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500
      ),
    );
  }
}
