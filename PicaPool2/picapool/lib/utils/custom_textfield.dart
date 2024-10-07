import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key, required this.controller, required this.hint, this.icon});
  final TextEditingController controller;
  final String hint;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff333399).withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.montserrat(
          color: const Color(0xff333333),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 54, maxWidth: 54),
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            color: const Color(0xffAAAAAA),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xffFF8D41), width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xffFF8D41), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xffFF8D41), width: 2),
          ),
        ),
      ),
    );
  }
}
