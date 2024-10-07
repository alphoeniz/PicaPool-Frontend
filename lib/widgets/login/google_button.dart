import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff333399).withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, 3))
          ],
          color: Colors.white,
          border: Border.all(color: const Color(0xffBDBDBD))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){},
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/icons/google.png", scale: 0.85,)),
              Center(
                child: Text(
                  "Continue with Google",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffAAAAAA)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
