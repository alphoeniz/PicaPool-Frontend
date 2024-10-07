import 'package:flutter/material.dart';
import 'package:picapool/utils/center_custom_text.dart';

class OnlineOfflineSwtich extends StatefulWidget {
  const OnlineOfflineSwtich(
      {super.key, this.isOffline = true, required this.onChange});
  final bool isOffline;
  final void Function(bool) onChange;

  @override
  State<OnlineOfflineSwtich> createState() => _OnlineOfflineSwtichState();
}

class _OnlineOfflineSwtichState extends State<OnlineOfflineSwtich> {
  bool isActive = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      isActive = widget.isOffline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffAAAAAA), width: 1,strokeAlign: BorderSide.strokeAlignOutside),
        boxShadow: [
          BoxShadow(
              color: const Color(0xff333399).withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                  color: isActive ? const Color(0xff2D0090) : Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isActive = true;
                    });
                    widget.onChange(true);
                  },
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  child: CenterAlignText(
                      text: "Offline",
                      size: 16,
                      fontWeight: FontWeight.w500,
                      color: isActive ? Colors.white : const Color(0xffAAAAAA)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                  color: isActive ? Colors.white : const Color(0xff2D0090),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isActive = false;
                    });
                    widget.onChange(false);
                  },
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  child: CenterAlignText(
                      text: "Online",
                      size: 16,
                      fontWeight: FontWeight.w500,
                      color: isActive ? const Color(0xffAAAAAA) : Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
