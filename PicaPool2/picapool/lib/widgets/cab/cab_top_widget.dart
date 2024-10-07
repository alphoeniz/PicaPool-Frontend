import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/utils/svg_icon.dart';

class CabTopWidget extends StatelessWidget {
  const CabTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(11)),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Column(
                  children: [
                    SvgIcon("assets/icons/start.svg"),
                    SizedBox(
                      height: 2,
                    ),
                    SvgIcon("assets/icons/line.svg"),
                    SizedBox(
                      height: 2,
                    ),
                    SvgIcon("assets/icons/end.svg"),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "6th street, Connaught place, New Delhi, India",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      Text(
                        "6th street, Connaught place, New Delhi, India",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SvgIcon("assets/icons/leftArrow.svg"),
                const SizedBox(
                  width: 31,
                ),
                Text(
                  "24 June , 2024",
                  style: GoogleFonts.montserrat(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 31,
                ),
                const SvgIcon("assets/icons/rightArrow.svg"),
              ],
            ),
          )
        ],
      ),
    );
  }
}