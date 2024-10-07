import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/utils/svg_icon.dart';

class AwayWidget extends StatelessWidget {
  const AwayWidget(
      {super.key, required this.distance1, required this.distance2});
  final double distance1;
  final double distance2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SvgIcon("assets/icons/loc.svg"),
              const SizedBox(width: 4,),
              Text(
                '${distance1}m away',
                style: GoogleFonts.outfit(
                    fontSize: 9, fontWeight: FontWeight.w300),
              ),
              const SizedBox(width: 4,),
              SvgIcon(distance1 < 250
                  ? "assets/icons/man_green.svg"
                  : distance1 < 500
                      ? "assets/icons/man_orange.svg"
                      : "assets/icons/man_red.svg"),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SvgIcon("assets/icons/pin.svg"),
              const SizedBox(
                width: 4,
              ),
              Text(
                '${distance2}m away',
                style: GoogleFonts.outfit(
                    fontSize: 9, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                width: 4,
              ),
              SvgIcon(distance2 < 250
                  ? "assets/icons/man_green.svg"
                  : distance2 < 500
                      ? "assets/icons/man_orange.svg"
                      : "assets/icons/man_red.svg"),
            ],
          ),
        ],
      ),
    );
  }
}