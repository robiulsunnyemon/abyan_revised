import 'dart:core';

import 'package:abyansf_asfmanagment_app/controller/event_controller/event_controller.dart';
import 'package:abyansf_asfmanagment_app/controller/profile_controller/profile_controller.dart';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/view/screens/main_screen/event_screen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/main_screen/explore_screen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/main_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/contact_whatsapp_controller/contact_whatsapp_controller.dart';
import '../../controller/highlight_controller/highlight_controller.dart';
import '../../controller/listing_controller/listing_controller.dart';
import '../../controller/main_category_controller/main_category_controller.dart';
import '../../controller/mini_sub_category_controller/mini_sub_category_controller.dart';
import '../../controller/specific_category_controller/specific_category_controller.dart';
import '../../controller/sub_category_controller/sub_category_controller.dart';
import '../../view_models/controller/carousel_controller.dart';
import '../../view_models/controller/image_picker_controller.dart';
import '../screens/profile_screen/profile_screen.dart';


class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;

@override
  void initState() {
  Get.put(EventController());
  Get.put(SubCategoryController());
  Get.put(HighlightController());
  Get.put(SpecificCategoryController());
  Get.put(ContactWhatsappController());
  Get.put(ListingDetailController());
  Get.put(MiniSubCategoryController());
  Get.put(MainCategoryController());
  Get.put(ProfileController());
  Get.put(ImagePickerController());
  Get.put(CarouselSliderControllers());


  super.initState();
  }

  final List<Widget> _pages = [
    HomeScreen(),
    EventScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];
  final List<String> label = ['Home', 'Events', 'Explore',  'Profile'];
  final List<String> icons = [
    AssetPath.navHome,
    AssetPath.navEvents,
    AssetPath.navExplore,
    AssetPath.navProfile,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [BoxShadow(
            color: Colors.black,
            offset: Offset(0, 10),
            blurRadius: 25
          )],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(icons.length, (index){
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(icons[index],
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.primaryDeepColor : AppColors.blackColor,
                    BlendMode.srcIn,
                  ),),
                  SizedBox(height: 4),
                  Text(label[index], style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 8,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),)
                ],
              ),
            );
          }),
        ),
      )
    );
  }
}
