
import 'dart:convert';

import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/view/auth/loginScreen.dart';
import 'package:abyansf_asfmanagment_app/view/auth/resendOTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api_services/otp_verification_api_services/otp_verification_api_services.dart';
import '../../api_services/resend_otp_verification_screen/resend_otp_verification.dart';
import '../../utils/style/appColor.dart';
import '../../view_models/controller/recovery_verification_controller.dart';

// class RecoveryVerificationScreen extends StatelessWidget {
//   RecoveryVerificationScreen({super.key});
//
//   final RecoveryVerificationController _controller = Get.find();
//   Widget _buildOtpBox(int index) {
//     return Obx(() => AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: _controller.hasError.value
//               ? Colors.red
//               : _controller.focusNodes[index].hasFocus
//               ? _controller.goldColor
//               : Colors.grey.shade300,
//           width: 2,
//         ),
//         boxShadow: _controller.focusNodes[index].hasFocus
//             ? [
//           BoxShadow(
//             color: _controller.goldColor.withOpacity(0.2),
//             blurRadius: 8,
//             spreadRadius: 1,
//             offset: const Offset(0, 2),
//           ),
//         ]
//             : [],
//       ),
//       child: TextField(
//         controller: _controller.controllers[index],
//         focusNode: _controller.focusNodes[index],
//         maxLength: 1,
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         onChanged: (value) => _controller.onChanged(value, index),
//         decoration: const InputDecoration(
//           counterText: "",
//           border: InputBorder.none,
//         ),
//       ),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 60),
//               const Text("Verification",
//                   style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.w700,
//                       fontFamily: 'PlayfairDisplay')),
//               const SizedBox(height: 10),
//               const Text("We sent Verification code to your email",
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: 'Inter',
//                       color: Colors.black54)),
//               const SizedBox(height: 40),
//
//               // OTP Inputs
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(4, _buildOtpBox),
//               ),
//
//               Obx(() => _controller.hasError.value
//                   ? Padding(
//                 padding: const EdgeInsets.only(top: 12),
//                 child: Text(
//                   'Incorrect code. Please try again.',
//                   style: TextStyle(
//                       color: Colors.red.shade400, fontSize: 14),
//                 ),
//               )
//                   : const SizedBox()),
//
//               const SizedBox(height: 40),
//
//               // Confirm Button
//               Obx(() => SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _controller.isVerifying.value
//                       ? null
//                       : _controller.verifyCode,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _controller.goldColor,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     elevation: 4,
//                   ),
//                   child: _controller.isVerifying.value
//                       ? const SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                       : const Text('Confirm',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontFamily: 'Inter')),
//                 ),
//               )),
//
//               const SizedBox(height: 20),
//
//               // Resend Link
//               Obx(() => Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Didn't receive a code? ",
//                       style: TextStyle(fontFamily: 'Inter')),
//                   GestureDetector(
//                     onTap: _controller.start.value == 0
//                         ? _controller.startTimer
//                         : null,
//                     child: Text("Resend",
//                         style: TextStyle(
//                             color: _controller.goldColor,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Inter')),
//                   ),
//                 ],
//               )),
//
//               const SizedBox(height: 10),
//
//               // Timer
//               Obx(() => Text(
//                 '00:${_controller.start.value.toString().padLeft(2, '0')} sec',
//                 style: TextStyle(
//                   color: _controller.goldColor,
//                   fontSize: 16,
//                   fontFamily: 'Inter',
//                 ),
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//




//
//
// class RecoveryVerificationScreen extends StatefulWidget {
//   const RecoveryVerificationScreen({super.key});
//
//   @override
//   State<RecoveryVerificationScreen> createState() => _RecoveryVerificationScreenState();
// }
//
// class _RecoveryVerificationScreenState extends State<RecoveryVerificationScreen> {
//
//
//   final RecoveryVerificationController _controller = Get.put(RecoveryVerificationController());
//
//
//   final List<TextEditingController> _controllers =
//   List.generate(4, (index) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
//
//   bool _hasError = false;
//
//   void _onChanged(String value, int index) {
//     if (value.isNotEmpty && index < 3) {
//       // Next box এ ফোকাস নেবে
//       FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
//     }
//     if (value.isEmpty && index > 0) {
//       // আগের box এ ফোকাস নেবে
//       FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
//     }
//   }
//
//
//   Future<void> _verifyOtp() async {
//
//     String otp = _controllers.map((c) => c.text).join();
//     setState(() => _hasError = false);
//
//     if (otp.length != 4) {
//       setState(() => _hasError = true);
//       return;
//     }
//
//     try {
//       await AuthPrefService.loadEmail();
//       String email = AuthPrefService.userEmail.value;
//
//       if (email.trim().isEmpty) {
//         setState(() => _hasError = true);
//         return;
//       }
//
//       final response = await OtpVerificationApiServices.postOtp(
//           otp: otp,
//           email: email
//       );
//
//       print(response.statusCode);
//
//       if (response.statusCode == 200) {
//         // Successful verification
//         Get.offAll(() => LoginScreen());
//       } else {
//         // Handle different status codes
//         final responseBody = jsonDecode(response.body);
//         setState(() => _hasError = true);
//         Get.snackbar(
//           'Error',
//           responseBody['message'] ?? 'Verification failed',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       setState(() => _hasError = true);
//       Get.snackbar(
//         'Error',
//         'An error occurred: ${e.toString()}',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   Widget _buildOtpBox(int index) {
//     return Container(
//       width: 60,
//       height: 60,
//       margin: const EdgeInsets.symmetric(horizontal: 6),
//       child: TextField(
//         controller: _controllers[index],
//         focusNode: _focusNodes[index],
//         textAlign: TextAlign.center,
//         maxLength: 1,
//         keyboardType: TextInputType.number,
//         style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         decoration: InputDecoration(
//           counterText: "",
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: _hasError ? Colors.red : Colors.grey.shade400,
//               width: 2,
//             ),
//           ),
//         ),
//         onChanged: (value) => _onChanged(value, index),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Verification',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: const Color(0xFF1A1A1A) /* Woodsmoke-950 */,
//                 fontSize: 32,
//                 fontFamily: 'PlayfairDisplay',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'We sent Verification code to your email',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 12,
//                 fontFamily: 'Inter',
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             const SizedBox(height: 40),
//
//             // OTP Box Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(4, _buildOtpBox),
//             ),
//
//             if (_hasError)
//               const Padding(
//                 padding: EdgeInsets.only(top: 12),
//                 child: Text(
//                   "Incorrect code. Please try again.",
//                   style: TextStyle(color: Colors.red, fontSize: 14),
//                 ),
//               ),
//
//             const SizedBox(height: 40),
//
//             // Confirm Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _verifyOtp,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:  _controller.goldColor,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   "Verify",
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             // Resend Link
//             Obx(() => Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Didn't receive a code? ",
//                     style: TextStyle(fontFamily: 'Inter')),
//                 GestureDetector(
//                   onTap: _controller.start.value == 0
//                       ? _controller.startTimer
//                       : null,
//                   child: InkWell(
//                     onTap: (){
//                       ResendOTPVerificationApiService.resendOTPRequest();
//
//                       //clear all otp
//
//                     },
//                     child: Text("Resend",
//                         style: TextStyle(
//                             color: _controller.goldColor,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Inter')),
//                   ),
//                 ),
//               ],
//             )),
//
//             const SizedBox(height: 10),
//
//             // Timer
//             Obx(() => Text(
//               '00:${_controller.start.value.toString().padLeft(2, '0')} sec',
//               style: TextStyle(
//                 color: _controller.goldColor,
//                 fontSize: 16,
//                 fontFamily: 'Inter',
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';

import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/view/auth/loginScreen.dart';
import 'package:abyansf_asfmanagment_app/view/auth/resendOTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api_services/otp_verification_api_services/otp_verification_api_services.dart';
import '../../api_services/resend_otp_verification_screen/resend_otp_verification.dart';
import '../../utils/style/appColor.dart';
import '../../view_models/controller/recovery_verification_controller.dart';

class RecoveryVerificationScreen extends StatefulWidget {
  const RecoveryVerificationScreen({super.key});

  @override
  State<RecoveryVerificationScreen> createState() => _RecoveryVerificationScreenState();
}

class _RecoveryVerificationScreenState extends State<RecoveryVerificationScreen> {
  final RecoveryVerificationController _controller = Get.put(RecoveryVerificationController());
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  bool _hasError = false;

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  // Function to clear all OTP fields
  void _clearAllOtpFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    // Reset focus to the first field
    FocusScope.of(context).requestFocus(_focusNodes[0]);
    setState(() => _hasError = false);
  }

  Future<void> _verifyOtp() async {
    String otp = _controllers.map((c) => c.text).join();
    setState(() => _hasError = false);

    if (otp.length != 4) {
      setState(() => _hasError = true);
      return;
    }

    try {
      await AuthPrefService.loadEmail();
      String email = AuthPrefService.userEmail.value;

      if (email.trim().isEmpty) {
        setState(() => _hasError = true);
        return;
      }

      final response = await OtpVerificationApiServices.postOtp(
          otp: otp,
          email: email
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        Get.offAll(() => LoginScreen());
      } else {
        final responseBody = jsonDecode(response.body);
        setState(() => _hasError = true);
        Get.snackbar(
          'Error',
          responseBody['message'] ?? 'Verification failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      setState(() => _hasError = true);
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _hasError ? Colors.red : Colors.grey.shade400,
              width: 2,
            ),
          ),
        ),
        onChanged: (value) => _onChanged(value, index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verification',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1A1A1A),
                fontSize: 32,
                fontFamily: 'PlayfairDisplay',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We sent Verification code to your email',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),

            // OTP Box Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, _buildOtpBox),
            ),

            if (_hasError)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  "Incorrect code. Please try again.",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),

            const SizedBox(height: 40),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _controller.goldColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Resend Link
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive a code? ",
                    style: TextStyle(fontFamily: 'Inter')),
                GestureDetector(
                  onTap: _controller.start.value == 0
                      ? () {
                    _controller.startTimer();
                    _clearAllOtpFields(); // Clear OTP fields when resend is tapped
                    ResendOTPVerificationApiService.resendOTPRequest();
                  }
                      : null,
                  child: Text("Resend",
                      style: TextStyle(
                          color: _controller.goldColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter')),
                ),
              ],
            )),

            const SizedBox(height: 10),

            // Timer
            Obx(() => Text(
              '00:${_controller.start.value.toString().padLeft(2, '0')} sec',
              style: TextStyle(
                color: _controller.goldColor,
                fontSize: 16,
                fontFamily: 'Inter',
              ),
            )),
          ],
        ),
      ),
    );
  }
}