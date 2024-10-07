import 'package:flutter/material.dart';
import 'package:picapool/utils/center_custom_text.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: CenterAlignText(
              text: "PicaPool",
              size: 26,
              fontWeight: FontWeight.w700,
              color: Colors.orange)),
    );
  }
}
