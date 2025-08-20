import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/jets_screen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/order_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomGridItem extends StatelessWidget {
  final List<Widget> targetScreens;
  const CustomGridItem({super.key, required this.targetScreens});

  @override
  Widget build(BuildContext context) {


    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      // Add your desired item count
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14.0,
        crossAxisSpacing: 14.0,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => targetScreens[index]),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 169,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetPath.diningImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text('Dinning', style: AppTextStyle.bold16),
            ],
          ),
        );
      },
    );
  }
}
