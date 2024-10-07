import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/utils/svg_icon.dart';
import 'package:picapool/widgets/cab/away_widget.dart';

class CabShareCard extends StatefulWidget {
  const CabShareCard({super.key, this.isBooked = false});
  final bool isBooked;

  @override
  State<CabShareCard> createState() => _CabShareCardState();
}

class _CabShareCardState extends State<CabShareCard> {
  Widget addressWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          color: const Color(0xffFFEDE2),
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: SvgIcon(
                    "assets/icons/loc.svg",
                    size: 10,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "149, Veena Delvai Indus Est, S V Rd, Opp Post Office, Jogeshwari, New Delhi - 6000482",
                    style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: SvgIcon(
                    "assets/icons/pin.svg",
                    size: 10,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "6th street, Connaught place, Connaught place, New Delhi - 6000932",
                    style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffFF8D41), width: 0.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5:45 pm",
                      style: GoogleFonts.montserrat(
                          fontSize: 19.04, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 96,
                      child: Text(
                        widget.isBooked
                            ? "Vehicle booked "
                            : "Vehicle not booked yet",
                        style: GoogleFonts.outfit(
                            color: widget.isBooked
                                ? const Color(0xff1DCF00)
                                : const Color(0xffCF0000),
                            fontSize: 9,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SvgIcon("assets/icons/person.svg"),
                        const SizedBox(width: 6),
                        Text(
                          "2 In room",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 9,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 8),
                  const AwayWidget(distance1: 140, distance2: 264),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isClicked = !isClicked;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "See Address",
                          style: GoogleFonts.outfit(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(width: 4),
                        const SvgIcon("assets/icons/expandArrow.svg"),
                      ],
                    ),
                  ),
                ],
              ),
              const SvgIcon("assets/icons/chatButton.svg"),
            ],
          ),
          if (isClicked) addressWidget(),
        ],
      ),
    );
  }
}