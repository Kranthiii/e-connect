import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smart_talk/controllers/auth_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_talk/screens/otp_page.dart';
import 'package:smart_talk/utilities/custom_button.dart';

class OTPScreen extends StatefulWidget {
  final String? number;
  const OTPScreen({Key? key, this.number});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String currentString = "";
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder(
          init: authController,
          builder: (AuthController _) {
            return _.isLoading ? const CircularProgressIndicator() :
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpHeader(phoneNumber: widget.number ?? "",),
                const SizedBox(height: 44),
                Pinput(
                  length: 6,
                  onChanged: (String pin) {
                    currentString = pin;
                  },
                ),
                Text(
                  'Didn’t receive code?',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color.fromRGBO(62, 116, 165, 1),
                  ),
                ),
                Text(
                  'Resend',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    color: const Color.fromRGBO(62, 116, 165, 1),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                DefaultButton(
                  text: "Verify",
                  margins: 10.0,
                  press: () {
                    setState(() {
                      authController.otpVerify(currentString);
                    });
                  },
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
