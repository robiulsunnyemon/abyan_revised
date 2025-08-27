import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/screens/constant/constans.dart';
import 'package:abyansf_asfmanagment_app/view/screens/listing_form/beach_club_form.dart';
import 'package:abyansf_asfmanagment_app/view/screens/listing_form/nightlife_form.dart';
import 'package:abyansf_asfmanagment_app/view/screens/single_services_pages/menu_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/card_container.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/view/widget/day_time_row.dart';
import 'package:abyansf_asfmanagment_app/view/widget/carousel_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/listing_controller/listing_controller.dart';
import '../../../view_models/controller/carousel_controller.dart';
import '../listing_form/restaurant_form.dart';
import 'listing_sub_image_screen.dart';

class SingleBeachClubScreen extends StatelessWidget {
  final int listingId;
  SingleBeachClubScreen({super.key, required this.listingId});

  final CarouselSliderControllers _carouselSliderController = Get.find();
  final _listingController = Get.put(ListingDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 290,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          _listingController.listingData.value?.mainImage ??
                              AppConstants.defaultImageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white70.withAlpha(100),
                          child: Icon(Icons.keyboard_arrow_left_outlined),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 180.w,
                              child: Text(
                                _listingController.listingData.value?.name ??
                                    "Default Name",
                                style: AppTextStyle.bold20,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: AppColors.blackColor,
                                ),
                                const SizedBox(width: 4),
                                SizedBox(
                                  width: 130.w,
                                  child: Text(
                                    _listingController
                                            .listingData
                                            .value
                                            ?.location ??
                                        "Default Location",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: AppStyles.fontXS,
                                      fontWeight: AppStyles.weightRegular,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        ElevatedButton(
                          onPressed: () {
                            if (_listingController.listingData.value !=
                                null) {
                              Get.to(
                                    () => MenuScreen(
                                  listingDetailData:
                                  _listingController.listingData.value!,
                                ),
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Menu"),
                              Icon(
                                Icons.arrow_circle_right_outlined,
                                color: AppColors.blackColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(height: 18),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Photos", style: AppTextStyle.bold24),
                            InkWell(
                              onTap: () {
                                if (_listingController.listingData.value !=
                                    null) {
                                  Get.to(
                                    () => ListingSubImageScreen(
                                      listingDetailData:
                                          _listingController.listingData.value!,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  fontFamily: "PlayfairDisplay",
                                  fontWeight: AppStyles.weightMedium,
                                  fontSize: AppStyles.fontL,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount:
                                _listingController
                                    .listingData
                                    .value
                                    ?.subImages
                                    .length ??
                                0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _listingController.indexSubImage.value =
                                      index;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Container(
                                    width: 146,
                                    height: 100,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          _listingController
                                                  .listingData
                                                  .value
                                                  ?.subImages[index] ??
                                              AppConstants.defaultImageUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    // Indicator Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _listingController
                                      .listingData
                                      .value
                                      ?.subImages
                                      .length ??
                                  0,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    width:
                                        _listingController
                                                .indexSubImage
                                                .value ==
                                            index
                                        ? 16
                                        : 5,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color:
                                          _listingController
                                                  .indexSubImage
                                                  .value ==
                                              index
                                          ? AppColors
                                                .primaryColor // Active color
                                          : AppColors
                                                .lightGrey, // Inactive color
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text("Member Privileges", style: AppTextStyle.bold24),
                    const SizedBox(height: 10),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: CardContainer(image: AssetPath.priorityImage),
                        ),
                        Expanded(
                          child: CardContainer(image: AssetPath.drinkImage),
                        ),
                        Expanded(
                          child: CardContainer(image: AssetPath.otherImage),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Drink on arrival and  appetizer",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: AppStyles.fontS,
                        fontWeight: AppStyles.weightRegular,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text("Description", style: AppTextStyle.bold24),
                    const SizedBox(height: 10),
                    Text(
                      _listingController.listingData.value?.description ?? "",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: AppStyles.fontM,
                        fontWeight: AppStyles.weightRegular,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("Hours", style: AppTextStyle.bold24),
                    const SizedBox(height: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        _listingController.listingData.value?.hours.length ?? 0,
                        (index) => Text(
                          _listingController.listingData.value?.hours[index] ??
                              "",
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColors.lightLaserColor,
                                ),
                                borderRadius: BorderRadiusGeometry.circular(4),
                              ),
                            ),
                            child: Text('Cancel'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_listingController
                                      .listingData
                                      .value
                                      ?.hasForm ==
                                  true) {
                                if (_listingController
                                        .listingData
                                        .value
                                        ?.fromName ==
                                    "Restaurants") {
                                  Get.to(
                                    () => RestaurantFormScreen(
                                      venueName: _listingController
                                          .listingData
                                          .value!
                                          .fromName!,
                                      listingId: _listingController
                                          .listingData
                                          .value!
                                          .id,
                                    ),
                                  );
                                }
                                if (_listingController
                                        .listingData
                                        .value
                                        ?.fromName ==
                                    "Beach club") {
                                  Get.to(
                                    () => BeachClubForm(
                                      venueName: _listingController
                                          .listingData
                                          .value!
                                          .fromName!,
                                      listingId: _listingController
                                          .listingData
                                          .value!
                                          .id,
                                    ),
                                  );
                                }
                                if (_listingController
                                        .listingData
                                        .value
                                        ?.fromName ==
                                    "Nightlife") {
                                  Get.to(
                                    () => NightlifeForm(
                                      venueName: _listingController
                                          .listingData
                                          .value!
                                          .fromName!,
                                      listingId: _listingController
                                          .listingData
                                          .value!
                                          .id,
                                    ),
                                  );
                                }
                                if (_listingController
                                        .listingData
                                        .value
                                        ?.fromName ==
                                    "Wellness") {
                                  Get.to(
                                    () => NightlifeForm(
                                      venueName: _listingController
                                          .listingData
                                          .value!
                                          .fromName!,
                                      listingId: _listingController
                                          .listingData
                                          .value!
                                          .id,
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Request'),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_circle_right_outlined),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
