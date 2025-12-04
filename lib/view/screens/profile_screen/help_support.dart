
import 'package:abyansf_asfmanagment_app/controller/contact_whatsapp_controller/contact_whatsapp_controller.dart';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class HelpSupport extends StatelessWidget {
  HelpSupport({super.key});

  final _contactWhatsappController = Get.put(ContactWhatsappController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              CustomAppBar(title: 'Help & Support'),
              SizedBox(height: 30),
              Image.asset(AssetPath.helpImage, scale: 3),
              SizedBox(height: 10),
              Text(
                'Hello, How can we Help you?',
                style: AppTextStyle.regular30.copyWith(
                  fontFamily: "copperplategothic",
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              Obx(() {
                final serviceData =
                    _contactWhatsappController.serviceData.value;

                // Loading stage
                if (_contactWhatsappController.isLoading.value) {
                  return CircularProgressIndicator();
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      final whatsappUrl =
                          serviceData?.adminWhatsApp?.mobileWhatsappLink ?? "";

                      try {
                        await launchUrl(
                          Uri.parse(whatsappUrl),
                          mode: LaunchMode.externalApplication,
                        );
                      } catch (e) {
                        // fallback
                       await launchUrl(
                          Uri.parse(
                              "https://play.google.com/store/apps/details?id=com.whatsapp"),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Image.asset(AssetPath.whatsappIcon,scale: 4,),
                        SizedBox(width: 8,),
                        Text("Support  Chat",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}


