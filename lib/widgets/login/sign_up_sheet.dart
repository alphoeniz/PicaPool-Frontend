import 'package:flutter/material.dart';
import 'package:picapool/utils/center_custom_text.dart';
import 'package:picapool/utils/custom_textfield.dart';
import 'package:picapool/utils/large_button.dart';
import 'package:picapool/widgets/login/add_pic_sheet.dart';

class SignUpBottomSheet extends StatefulWidget {
  const SignUpBottomSheet({super.key});

  @override
  State<SignUpBottomSheet> createState() => _SignUpBottomSheetState();
}

class _SignUpBottomSheetState extends State<SignUpBottomSheet> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool isButtonEnable = false;

  void buttonStatus() {
    setState(() {
      isButtonEnable = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          userNameController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    firstNameController.addListener(buttonStatus);
    lastNameController.addListener(buttonStatus);
    userNameController.addListener(buttonStatus);
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
                    text: "Finish Signing Up!",
                    size: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff333333)),
                CenterAlignText(
                    text: "You are just one step away!",
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff333333).withOpacity(0.5)),
                const SizedBox(height: 36),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextfield(
                            controller: firstNameController, hint: "First Name")),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: CustomTextfield(
                            controller: lastNameController, hint: "Last Name")),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextfield(controller: userNameController, hint: "Username"),
                const SizedBox(height: 45),
                LargeButton(
                  text: "Next",
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: false,
                        enableDrag: false,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (ctx) => const AddProfilePicBottomSheet());
                  },
                  isEnabled: isButtonEnable,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
