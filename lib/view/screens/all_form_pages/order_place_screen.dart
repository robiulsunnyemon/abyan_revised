import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/style/appColor.dart';
import '../../widget/custom_bottom_bar.dart';

class OrderPlaceScreen extends StatelessWidget {
  const OrderPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      AssetPath.orderPlace,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('Your Request is in Process',style: AppTextStyle.bold24,),
                      SizedBox(height: 10),
                      Text(
                        'Thank you, you will receive a confirmation shortly.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                  SizedBox(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => CustomBottomBar());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.lightLaserColor,
                                  ),
                                  borderRadius: BorderRadiusGeometry.circular(4)
                              )
                          ),
                          child: Text('Go to home'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(onPressed: (){
                          Get.to(() => CustomBottomBar(initialIndex: 3));
                        },
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Go to profile'),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_circle_right_outlined)
                            ],
                          ),),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
