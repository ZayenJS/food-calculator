import 'package:flutter/material.dart';

class Input {
  String label;
  TextEditingController controller;
  Function(String)? onChanged;
  String? error;

  Input({
    required this.label,
    required this.controller,
    this.onChanged,
    this.error,
  });
}
