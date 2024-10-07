import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/utils/svg_icon.dart';
import 'package:picapool/widgets/cab/cab_bottom_sheet.dart';
import 'package:picapool/widgets/cab/cab_top_widget.dart';

class CabShareScreen extends StatelessWidget {
  const CabShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(),
            const CabTopWidget(),
            const SizedBox(
              height: 29,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: const CabBottomSheet(),
              ),
            ),
            // Container(alignment: Alignment.bottomCenter, child: const CabBottomSheet()),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      child: Row(
        children: [
          const SvgIcon("assets/icons/back.svg"),
          const SizedBox(
            width: 12,
          ),
          Text(
            "Share a cab",
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}