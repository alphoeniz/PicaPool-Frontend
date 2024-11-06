import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/utils/center_custom_text.dart';
import 'package:picapool/utils/large_button.dart';
import 'package:picapool/widgets/login/sign_up_sheet.dart';

class OtpVerificationWidget extends StatefulWidget {
  const OtpVerificationWidget({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<OtpVerificationWidget> createState() => _OtpVerificationWidgetState();
}

class _OtpVerificationWidgetState extends State<OtpVerificationWidget> {
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  List<bool> hasError = [false, false, false, false];

  // String waitingtime =

  Timer? timer;
  int waitingTime = 59; //seconds
  bool isTimerStart = true;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (waitingTime <= 0) {
        timer.cancel();
        setState(() {
          isTimerStart = false;
        });
      } else {
        setState(() {
          waitingTime--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    timer?.cancel();
    super.dispose();
  }

  bool validateDigit(String value) {
    if (value.contains(' ') ||
        value.contains('-') ||
        value.contains(',') ||
        value.contains('.')) {
      return false;
    }
    return true;
  }

  Widget editNumber() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Center(
        child: Text(
          "Edit Number",
          style: GoogleFonts.montserrat(
              decorationColor: const Color(0xffAAAAAA),
              decoration: TextDecoration.underline,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xffAAAAAA)),
        ),
      ),
    );
  }

  Widget resendCode() {
    return InkWell(
      onTap: waitingTime > 0 ? null : () {},
      child: Center(
        child: Text(
          waitingTime > 0 ? "Resend Code (00:$waitingTime)" : "Resend Code",
          style: GoogleFonts.montserrat(
              color: const Color(0xffFFC266),
              fontSize: 15,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xffFFC266)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(34)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CenterAlignText(
                    text: "Verify Phone Number",
                    size: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff333333)),
                CenterAlignText(
                    text: "OTP sent to ${widget.phoneNumber}",
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff333333)),
                editNumber(),
                const SizedBox(
                  height: 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 75,
                      child: RawKeyboardListener(
                        focusNode: FocusNode(), // Create a new FocusNode
                        onKey: (event) {
                          if (event
                                  .isKeyPressed(LogicalKeyboardKey.backspace) &&
                              controllers[index].text.isEmpty &&
                              index > 0) {
                            FocusScope.of(context)
                                .requestFocus(focusNodes[index - 1]);
                          }
                        },
                        child: TextFormField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff333333)),
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xffFF8D41), width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: hasError[index]
                                    ? Colors.red
                                    : const Color(0xffFF8D41),
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: hasError[index]
                                    ? Colors.red
                                    : const Color(0xffFF8D41),
                                width: 2.5,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              hasError[index] = false;
                            });
                            if (value.length == 1 &&
                                index < 3 &&
                                validateDigit(value)) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            }
                            if (index == 3) {
                              String otpString = '';
                              bool allFilled = true;
                              for (int i = 0; i < 4; i++) {
                                otpString += controllers[i].text;
                                if (controllers[i].text.isEmpty) {
                                  allFilled = false;
                                  if (i != 3) {
                                    hasError[i] = true;
                                  }
                                }
                              }
                              setState(() {});
                              if (allFilled) {
                                print('OTP is: $otpString');
                              }
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 16,
                ),
                resendCode(),
                const SizedBox(
                  height: 32,
                ),
                LargeButton(
                    text: "Submit",
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: false,
                          enableDrag: false,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (ctx) => const SignUpBottomSheet());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
