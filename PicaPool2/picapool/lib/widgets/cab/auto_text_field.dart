import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AutoTextFieldWidget extends StatelessWidget {
  const AutoTextFieldWidget(
      {super.key, required this.controller, required this.hint});
  final TextEditingController controller;
  final String hint;
  // final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      textStyle: GoogleFonts.montserrat(
          color: const Color(0xff333333), fontSize: 14, fontWeight: FontWeight.w400),
      boxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffFF8D41), width: 1.2),
        boxShadow: [
          BoxShadow(
              color: const Color(0xff333399).withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3))
        ],
      ),
      textEditingController: controller,
      googleAPIKey: "AIzaSyA5-1f-M5kxCKGgISp6Q0GT00SECxJRoXs",
      inputDecoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.montserrat(
            color: const Color(0xff333333).withOpacity(0.5),
            fontSize: 14,
            fontWeight: FontWeight.w400),
        // prefixIcon: Icon(
        //   Icons.circle,
        //   color: Colors.green,
        //   size: 18,
        // ),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      countries: const ["in"],
      itemClick: (Prediction prediction) {
        controller.text = prediction.description!;
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: prediction.description!.length));
      },
      itemBuilder: (context, index, Prediction prediction) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(
                width: 7,
              ),
              Expanded(child: Text(prediction.description ?? ""))
            ],
          ),
        );
      },
    );
  }
}
