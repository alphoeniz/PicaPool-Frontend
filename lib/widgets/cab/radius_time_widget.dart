import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RadiusTimeFieldWidget extends StatefulWidget {
  const RadiusTimeFieldWidget(
      {super.key, required this.currentIndex, required this.values});
  final int currentIndex;
  final List<String> values;

  @override
  State<RadiusTimeFieldWidget> createState() => _RadiusTimeFieldWidgetState();
}

class _RadiusTimeFieldWidgetState extends State<RadiusTimeFieldWidget> {
  String initValue = "";
  int initIndex = 0;

  handleValueChange(int idx) {
    if (idx >= 0 && idx < widget.values.length) {
      setState(() {
        initValue = widget.values[idx];
        initIndex = idx;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      initValue = widget.values[widget.currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 52,
      width: size.width * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffFF8D41)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xff333399).withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3))
        ],
      ),
      child: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_rounded),
                onPressed: () {
                  handleValueChange(initIndex - 1);
                },
              ),
              Text(
                initValue,
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: const Color(0xff666666),
                    fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: () {
                  handleValueChange(initIndex + 1);
                },
              ),
            ]),
      ),
    );
  }
}
