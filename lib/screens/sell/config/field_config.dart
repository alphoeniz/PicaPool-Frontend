import 'package:flutter/material.dart';

class FieldConfig {
  final String label;
  final bool isRequired;
  final TextEditingController controller;

  FieldConfig({
    required this.label,
    this.isRequired = false,
    TextEditingController? controller,
  }) : controller = controller ?? TextEditingController();
}