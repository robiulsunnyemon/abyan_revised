// import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
// import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
// import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
// import 'package:abyansf_asfmanagment_app/view_models/controller/custom_bottom_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../utils/style/app_color.dart';
// import '../../utils/style/appColor.dart';
//
// class OrderPlaceScreen extends GetView<CustomBottomController> {
//   const OrderPlaceScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               // Center(child: Image.asset(AssetPath.orderPlaceImage)),
//               Column(
//                 children: [
//                   Text(
//                     'Your Request is in Process',
//                     style: AppTextStyle.bold24,
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Thank you, you will receive a confirmation shortly.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Get.offAll(() => CustomBottomBar(index: 0)); // Home
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.white,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           side: BorderSide(
//                             color: AppColors.lightLaserColor,
//                           ),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                       child: const Text('Go To Home'),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Get.offAll(() => CustomBottomBar(index: 3)); // Profile
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shadowColor: Colors.transparent,
//                         backgroundColor: AppColors.primaryDeepColor,
//                       ),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Go To Profile'),
//                           SizedBox(width: 10),
//                           Icon(Icons.arrow_circle_right_outlined),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }