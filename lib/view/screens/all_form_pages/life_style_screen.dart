import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_date_picker.dart';
import 'package:flutter/material.dart';

import '../../../utils/style/appColor.dart';
import '../../../utils/style/app_text_styles.dart';
import '../../widget/increase_and_decrease.dart';

class LifeStyleScreen extends StatelessWidget {
  const LifeStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: 'Dining'),
                Text('Name', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightLaserColor,
                        ),
                      ),
                      fillColor: AppColors.white,
                    ),
                  ),
                ),
                Text('Email', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightLaserColor,
                        ),
                      ),
                      fillColor: AppColors.white,
                    ),
                  ),
                ),
                Text('Contacts', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your WhatsApp number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightLaserColor,
                        ),
                      ),
                      fillColor: AppColors.white,
                    ),
                  ),
                ),
                Text('Date of reservation', style: AppTextStyle.bold16),
                Row(
                  children: [
                    CustomDatePicker(),
                  ],
                ),
                Text('Time', style: AppTextStyle.bold16),
                Row(
                  children: [
                    CustomDatePicker(),
                  ],
                ),
                Text('Number of guest', style: AppTextStyle.bold16),
                Row(
                  children: [
                    IncreaseAndDecrease(type: 'Adults'),
                    SizedBox(width: 10),
                    IncreaseAndDecrease(type: 'Children'),
                  ],
                ),
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
          ),
        ),
      ),
    );
  }
}
