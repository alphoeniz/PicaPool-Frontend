import 'package:flutter/material.dart';

Widget buildTextField(
      {required String label, required String hintText, required String errorText, required Function() onEditingComplete , required TextEditingController textEditingController , int? maxLength}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontFamily: 'MontserratR',
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: 'MontserratR',
              fontSize: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFA3A3A3), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFFF8D41), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          onEditingComplete: onEditingComplete,
          validator: (value) =>
                  value == null || value.isEmpty ? errorText : null,
          maxLength: maxLength,
          style: const TextStyle(fontSize: 14, fontFamily: 'MontserratR'),
        ),
      ],
    );
  }