import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart'; // SMS inbox package
import 'package:picapool/functions/auth/auth_controller.dart';
import 'dart:async';
import 'dart:convert';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  bool _isOtpComplete = false;
  bool _isOtpIncorrect = false;
  bool _isResendButtonDisabled = false;
  int _resendCountdown = 59;
  Timer? _timer;
  String? otpCode;
  final SmsQuery _smsQuery = SmsQuery();

  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _requestSmsPermission();
    for (var controller in _controllers) {
      controller.addListener(_checkOtpComplete);
    }
    _listenForSms();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(_checkOtpComplete);
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _requestSmsPermission() async {
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      await Permission.sms.request();
    }
  }

  void _listenForSms() async {
    final messages = await _smsQuery.querySms(
      kinds: [SmsQueryKind.inbox],
      sort: true,
      count: 10,
    );

    var dateTime = DateTime.now();

    for (SmsMessage message in messages) {
      if (_isOtpComplete) {
        break; // Stop listening if the user has already entered the code
      }
      debugPrint("SMS Received: ${message.body}");
      if (message.date != null &&
          message.date!.isAfter(dateTime) &&
          message.address == "CP-PICAPL" && // Check if the sender is CP-PICAPL
          message.body != null &&
          message.body!.contains("Your OTP for phone number verification is") &&
          message.body!.contains(" -PicaPool")) {
        otpCode = _extractOtp(message.body!);
        debugPrint("Extracted OTP: $otpCode");
        if (otpCode != null && otpCode!.length == 4) {
          for (int i = 0; i < otpCode!.length; i++) {
            _controllers[i].text = otpCode![i];
          }
          _verifyOtp();
        }
        break;
      }
    }
  }

  String? _extractOtp(String message) {
    final otpRegExp = RegExp(r'\d{4}');
    final match = otpRegExp.firstMatch(message);
    print("OTP regex match: ${match?.group(0)}");
    return match?.group(0);
  }

  void _checkOtpComplete() {
    setState(() {
      _isOtpComplete =
          _controllers.every((controller) => controller.text.length == 1);
    });
  }

  Future<void> _verifyOtp() async {
    String otp = _controllers.map((controller) => controller.text).join('');
    String url =
        'https://api.picapool.com/v2/otp/verify?otp=$otp&mobile=${widget.phoneNumber}';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        debugPrint('Response: $responseBody');
        if (responseBody.contains('"type":"success"') ||
            responseBody.contains('already verified')) {
          await authController.loginWithOtp(widget.phoneNumber, otp);
        } else {
          setState(() {
            _isOtpIncorrect = true;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Incorrect OTP. Please try again.')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to verify OTP. Please try again.')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred. Please try again later.')),
        );
      }
    }
  }

  Future<void> _resendOtp() async {
    String url = 'https://api.picapool.com/v2/otp?mobile=${widget.phoneNumber}';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobile': widget.phoneNumber,
        }),
      );

      if (response.statusCode == 201) {
        final responseBody = response.body;

        if (responseBody.contains('"type":"success"')) {
          setState(() {
            _isResendButtonDisabled = true;
            _resendCountdown = 59;
          });
          _startResendCountdown();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to resend OTP. $responseBody')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to resend OTP. Please try again.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred. Please try again later.')),
      );
    }
  }

  void _startResendCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _isResendButtonDisabled = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = authController.notLoading;

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter your code',
                  style: TextStyle(
                    fontFamily: "MontserratR",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.phoneNumber,
                  style: const TextStyle(
                    fontFamily: "MontserratR",
                    fontSize: 12,
                    color: Color(0xff7C7C7C),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _isOtpIncorrect
                                  ? Colors.red
                                  : const Color(0xffFF8D41),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _isOtpIncorrect
                                  ? Colors.red
                                  : const Color(0xffA3A3A3),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.only(bottom: 5),
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            _focusNodes[index + 1].requestFocus();
                          }
                          if (_isOtpIncorrect) {
                            setState(() {
                              _isOtpIncorrect = false;
                            });
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isOtpComplete ? _verifyOtp : null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return const Color(0xffC2C2C2);
                        }
                        return const Color(0xffFF8D41);
                      },
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return const Color(0xff626262);
                        }
                        return const Color(0xffFFFFFF);
                      },
                    ),
                    minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 50)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
                  ),
                  child: (!isLoading)
                      ? const Text(
                          "Next",
                          style: TextStyle(
                            fontFamily: "MontserratSB",
                            fontSize: 16,
                          ),
                        )
                      : const CircularProgressIndicator(),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Didn't get code?",
                  style: TextStyle(
                    fontFamily: "MontserratR",
                    fontSize: 12,
                    color: Color(0xff7C7C7C),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _isResendButtonDisabled ? null : _resendOtp,
                  child: Text(
                    _isResendButtonDisabled
                        ? "Resend ($_resendCountdown)"
                        : "Resend",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xffFF8D41),
                      fontFamily: "MontserratR",
                      fontSize: 12,
                      color: _isResendButtonDisabled
                          ? Colors.grey
                          : const Color(0xffFF8D41),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
