import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AsGuest extends StatelessWidget {
  const AsGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        "Continue as a Guest",
        style: GoogleFonts.montserrat(
            decorationColor: const Color(0xffAAAAAA),
            decoration: TextDecoration.underline,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xffAAAAAA)),
      ),
    );
  }
}
