import 'package:flutter/material.dart';

class Input {
  String text;
  TextEditingController controller;
  Function(String)? onChanged;

  Input({required this.text, required this.controller, this.onChanged});
}
