// whatsapp_message_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import '../../../controller/mini_sub_whatsapp_api_services/mini_sub_whatsapp_api_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/assets_path.dart';
import '../../../utils/style/appColor.dart';
import '../../../utils/style/app_text_styles.dart';

class MiniWhatsappMessageScreen extends StatelessWidget {
  MiniWhatsappMessageScreen({super.key});

  final ServiceController _contactWhatsappController = Get.put(
    ServiceController(),
  );

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Obx(() {
              final serviceData = _contactWhatsappController.serviceData.value;
              if (serviceData == null) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header Row
                  Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.goldenTextColor,
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_left_outlined,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(width: 10.w),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AssetPath.asfLogo),
                              fit: BoxFit.cover, // optional
                            ),
                          ),
                          height: 50, // or ScreenUtil: 100.h
                          width: 50, // or ScreenUtil: 100.w
                        ),
                        SizedBox(width: 10.w),
                        Flexible(
                          flex: 16,
                          child: Text(
                            serviceData.name,
                            style: AppTextStyle.bold24,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(width: 32), // Balance the row
                      ],
                    ),
                  ),
                  // Image Stack
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(serviceData.img),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceData.name,
                                style: AppTextStyle.bold20.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            style: TextStyle(color: AppColors.white),
                            serviceData.description is Map<String, dynamic>
                                ? (serviceData.description["content"] ?? "")
                                : serviceData.description?.toString() ??
                                      "No description available",
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      // WhatsApp Contact Card
                      Container(
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            colors: [Color(0xffDFD2A9), Color(0xffEEE9D3)],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'To learn more about this service in detail, contact now on WhatsApp.',
                                style: AppTextStyle.bold16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(elevation: 0),
                              onPressed: () async {
                                final whatsappUrl = serviceData
                                    .adminWhatsApp
                                    ?.mobileWhatsappLink;
                                debugPrint(
                                  "Attempting to launch: $whatsappUrl",
                                );
        
                                try {
                                  // First try launching directly without canLaunch check
                                  await launchUrl(
                                    Uri.parse(whatsappUrl!),
                                    mode: LaunchMode.externalApplication,
                                  );
                                } catch (e) {
                                  debugPrint(
                                    "Direct launch failed, trying alternative: $e",
                                  );
        
                                  // If direct launch fails, try with canLaunch check
                                  try {
                                    if (await canLaunch(whatsappUrl!)) {
                                      await launch(whatsappUrl!);
                                    } else {
                                      await launch(
                                        "https://play.google.com/store/apps/details?id=com.whatsapp",
                                        forceSafariVC: false,
                                        forceWebView: false,
                                      );
                                    }
                                  } catch (e2) {
                                    debugPrint("Fallback launch failed: $e2");
                                    // Show error to user
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Could not open WhatsApp",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text('WhatsApp'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
