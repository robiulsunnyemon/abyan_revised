import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controller/contact_whatsapp_controller/contact_whatsapp_controller.dart';
import '../../../utils/style/appColor.dart';

class MassageScreen extends StatelessWidget {
  MassageScreen({super.key});

  final _contactWhatsappController = Get.put(ContactWhatsappController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Obx(() {
            final serviceData = _contactWhatsappController.serviceData.value;

            if (serviceData == null) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
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
                              color: AppColors.greyBackgroundColor,
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_left_outlined,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(serviceData.name, style: AppTextStyle.bold24),
                        const Spacer(),
                        const SizedBox(width: 32), // Balance the row
                      ],
                    ),
                  ),

                  // Image Stack
                  Stack(
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
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serviceData.name,
                              style: AppTextStyle.bold20.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.white,
                                ),
                                Text(
                                  'Jumeirah Beach Residence',
                                  style: AppTextStyle.regular10.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                        child: Text(serviceData.description["content"]),),
                  ),
                  const SizedBox(height: 30),


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
                            final whatsappUrl =
                                serviceData.adminWhatsApp.mobileWhatsappLink;
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not open WhatsApp"),
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
            );
          }),
        ),
      ),
    );
  }
}
