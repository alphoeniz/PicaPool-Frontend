import 'package:flutter/material.dart';

Widget buildTextField(
      {required String label, required String hintText, required String errorText, required Function() onEditingComplete , required TextEditingController textEditingController , int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
            // autovalidateMode: AutovalidateMode.onUserInteraction,
      
            validator: (value){
               if ((value == null || value == '')) {
                return errorText;
              }
              return null;
            },
            maxLength: maxLength,
            style: const TextStyle(fontSize: 14, fontFamily: 'MontserratR'),
          ),
        ],
      ),
    );
  }


    Widget buildSmallTextField({
    required TextEditingController controller,
    required String hintText,
    required bool enabled,
  }) {
    return TextFormField(
       validator: (value) {
             if ((value == null || value == '')) {
                return 'This field is required.';
              }
              return null;
          },
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Colors.grey, fontFamily: 'MontserratR', fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: enabled ? const Color(0xFFA3A3A3) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFFF8D41),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      enabled: enabled,
      style: const TextStyle(fontSize: 14, fontFamily: 'MontserratR'),
    );
  }

  Widget buildUnderlineTextField({
    required String label,
    required String hintText,
    required TextEditingController textEditingController
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontFamily: 'MontserratR',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: textEditingController,
          validator: (value) {
             if ((value == null || value == '')) {
                return 'This field is required.';
              }
              return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: 'MontserratR',
              fontSize: 14,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
          ),
          style: const TextStyle(fontSize: 16, fontFamily: 'MontserratR'),
        ),
      ],
    );
  }

   showSnackBar({
    required String content,
    required BuildContext context,
  }){

    SnackBar snackBar = SnackBar(content: Text(content), backgroundColor: Colors.orange, behavior: SnackBarBehavior.floating , elevation: 3, );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);


  }