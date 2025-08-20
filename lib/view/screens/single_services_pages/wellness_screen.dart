import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/view/screens/main_screen/home_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/carousel_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  State<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gyms', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              CarouselContainer(
                imagePath: AssetPath.image14,
                title: "Fitness Gyms",
                location: "Down town Residence",
                personIcon: AssetPath.personImage,
                clockIcon: AssetPath.clockImage,
                width: double.infinity,
                height: 167,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
