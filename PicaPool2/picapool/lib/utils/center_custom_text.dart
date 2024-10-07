import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CenterAlignText extends StatelessWidget {
  const CenterAlignText({super.key, required this.text, required this.size, required this.fontWeight, required this.color});
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: GoogleFonts.montserrat(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}