import 'package:flutter/material.dart';

class Input {
  String label;
  TextEditingController controller;
  Function(String)? onChanged;
  TextInputType keyboardType;

  Input({
    required this.label,
    required this.controller,
    required this.keyboardType,
    this.onChanged,
  });
}
