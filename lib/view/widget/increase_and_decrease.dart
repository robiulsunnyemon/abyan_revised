import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/assets_path.dart';
import '../../utils/style/appColor.dart';
import '../../view_models/controller/counter_controller.dart';

class IncreaseAndDecrease extends StatelessWidget {
  IncreaseAndDecrease({super.key, required this.type});

  final CounterController counter = Get.put(CounterController());

  final String type;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightLaserColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  GestureDetector(
                    child: SvgPicture.asset(AssetPath.minusIcons),
                    onTap: () {
                      counter.decrement(type);
                    },
                  ),
                  Obx(()=>Text(counter.counterAdultChildrenMap[type].toString())),
                  GestureDetector(onTap: (){
                    counter.increment(type);
                  },child: SvgPicture.asset(AssetPath.plusIcons)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

