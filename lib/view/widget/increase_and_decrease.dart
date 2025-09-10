import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../utils/assets_path.dart';
import '../../utils/style/appColor.dart';
import '../../view_models/controller/counter_controller.dart';

class IncreaseAndDecrease extends StatelessWidget {
  final String type;
  final CounterController counter;

  const IncreaseAndDecrease({
    super.key,
    required this.type,
    required this.counter,
  });

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
                style: TextStyle(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: counter.decrease,
                    child: SvgPicture.asset(AssetPath.minusIcons),
                  ),
                  SizedBox(width: 10),
                  Obx(() => Text(counter.minus.toString())),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: counter.increase,
                    child: SvgPicture.asset(AssetPath.plusIcons),
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