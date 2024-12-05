import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final Function() onPressed;
  final String buttonLabel;
  const PrimaryButton({
    required this.onPressed,
    required this.buttonLabel,
    super.key});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Center(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: widget.onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFF8D41),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.buttonLabel ,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: "MontserratSB"),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
  }
}