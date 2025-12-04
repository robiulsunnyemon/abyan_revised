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
    final serviceData = _listingWhatsappController.listingData.value;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: 16),
            child: CustomAppBar(title: ''),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Obx(() {
            final serviceData = _listingWhatsappController.listingData.value;
            if (serviceData == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(
              child: SingleChildScrollView(
                child: Column(
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
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          style: TextStyle( 
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          serviceData.data?.description ?? "",
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xffDFD2A9), Color(0xffEEE9D3)],
                        ),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(bottom: 16.h),
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

                              child:  Text('WhatsApp',style: AppTextStyle.regular16.copyWith(color: AppColors.white),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
