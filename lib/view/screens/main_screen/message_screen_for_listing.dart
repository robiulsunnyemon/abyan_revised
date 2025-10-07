import 'package:abyansf_asfmanagment_app/controller/listing_whatsapp_controller/listing_whatsapp_controller.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/assets_path.dart';
import '../../../utils/style/appColor.dart';
import '../constant/constans.dart';

class MessageScreenForListing extends StatelessWidget {
  MessageScreenForListing({super.key});
  final _listingWhatsappController = Get.put(ListingWhatsappController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Obx(() {
            final serviceData = _listingWhatsappController.listingData.value;
            if (serviceData == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                // Header Row
                Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 32.h,
                          width: 32.w,
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
                      Flexible(
                        flex: 16,
                        child: Text(
                          serviceData.data?.name ?? "",
                          style: AppTextStyle.bold24,
                          maxLines: 1,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  children: [
                    Container(
                      height: 160.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(
                            serviceData.data?.mainImage ??
                                AppConstants.defaultImageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            serviceData.data?.name ?? "",
                            style: AppTextStyle.bold20.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Container(
                      height: 160.h,
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
                              final whatsappUrl =
                                  serviceData
                                      .data
                                      ?.adminWhatsApp
                                      ?.mobileWhatsappLink ??
                                  "";
                              debugPrint("Attempting to launch: $whatsappUrl");

                              try {
                                // First try launching directly without canLaunch check
                                await launchUrl(
                                  Uri.parse(whatsappUrl),
                                  mode: LaunchMode.externalApplication,
                                );
                              } catch (e) {
                                debugPrint(
                                  "Direct launch failed, trying alternative: $e",
                                );

                                // If direct launch fails, try with canLaunch check
                                try {
                                  if (await canLaunch(whatsappUrl)) {
                                    await launch(whatsappUrl);
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
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Could not open WhatsApp"),
                                      ),
                                    );
                                  }
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
    );
  }
}
