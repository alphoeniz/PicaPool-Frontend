import 'package:flutter/material.dart';
import 'package:picapool/widgets/cab/cab_card.dart';
import 'package:picapool/widgets/home/divider.dart';

class CabBottomSheet extends StatelessWidget {
  const CabBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        clipBehavior: Clip.antiAlias,
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(24, 2, 24, 0),
          // height: size.height * 0.6,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(29), topRight: Radius.circular(29)),
          ),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 22,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: CustomDivider(text: " Available rides "),
                ),
                SizedBox(
                  height: 28,
                ),
                CabShareCard(),
                SizedBox(
                  height: 12,
                ),
                CabShareCard(
                  isBooked: true,
                )
              ],
            ),
          ),
        ));
  }
}