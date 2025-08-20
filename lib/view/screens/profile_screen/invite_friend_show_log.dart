import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InviteFriendShowLog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Share',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 17.4,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(),
                Stack(
                  children: [
                    Container(
                      height: 115,
                      width: 318,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(7.25),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Add copy logic here
                        },
                        child: Container(
                          height: 44,
                          width: 318,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(7.25)),
                            color: AppColors.primaryDeepColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AssetPath.solarCopyOutline,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Copy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.6,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 318,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.25),
                    border: Border.all(
                      color: AppColors.lightGreyBorder,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetPath.icRoundEmail),
                      const SizedBox(width: 8),
                      const Text(
                        'Send by email',
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 11.6,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AssetPath.riWhatsappFill),
                    SvgPicture.asset(AssetPath.icSharpFacebook),
                    SvgPicture.asset(AssetPath.riMessengerFill),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
