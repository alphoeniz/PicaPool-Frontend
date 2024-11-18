import 'package:flutter/material.dart';

class ButtonModel {
  final String text;
  final VoidCallback onTap;
  final String? imagePath;

  ButtonModel({required this.text, required this.onTap, this.imagePath});
}
