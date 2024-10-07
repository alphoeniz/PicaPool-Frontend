import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 0.5,
            decoration: const BoxDecoration(
                color: Color(0xffFF8D41),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1),
                      color: Color(0xffFF8D41),
                      blurRadius: 1.0)
                ]),
          ),
        ),
        Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        Expanded(
          child: Container(
            height: 0.5,
            decoration: const BoxDecoration(
                color: Color(0xffFF8D41),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1),
                      color: Color(0xffFF8D41),
                      blurRadius: 1.0)
                ]),
          ),
        ),
      ],
    );
  }
}
