import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/style/appColor.dart';

class OrderPlaceScreen extends StatelessWidget {
  const OrderPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                      AssetPath.OrderPlaceImage,
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
                          color: Colors.black,
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
                          onPressed: () {},
                          child: Text('Cancel'),
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
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Request'),
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
