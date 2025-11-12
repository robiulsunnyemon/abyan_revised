import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/listing_controller/listing_controller.dart';
import '../../../controller/listing_whatsapp_controller/listing_whatsapp_controller.dart';
import '../../../controller/specific_category_controller/specific_category_controller.dart';
import '../../../utils/assets_path.dart';
import '../../../utils/style/app_text_styles.dart';
import '../../widget/specific_carausel_container.dart';
import '../constant/constans.dart';

class SpecificCategoryDetailsScreen extends StatelessWidget {
  SpecificCategoryDetailsScreen({super.key});

  final _specificCategoryController = Get.put(SpecificCategoryController());
  final _listingController = Get.put(ListingDetailController());
  final _listingWhatsappController = Get.put(ListingWhatsappController());

  Future<void> _onRefresh() async {
    _specificCategoryController.specificCategories();
  }

  @override
  Widget build(BuildContext context) {
    print("lo");
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Scaffold(
        body: SafeArea(
          child: Obx(
            () => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 160.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          _specificCategoryController
                                  .subcategory
                                  .value
                                  ?.heroSectionImg ??
                              AppConstants.defaultImageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.goldenTextColor,
                            child: Icon(Icons.keyboard_arrow_left_outlined,color: AppColors.white,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_specificCategoryController.specificCategories.isNotEmpty)
                  SliverList.builder(
                    itemCount:
                        _specificCategoryController.specificCategories.length,
                    itemBuilder: (context, categoryIndex) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            child: Text(
                              _specificCategoryController
                                  .specificCategories[categoryIndex]
                                  .name,
                              style: AppTextStyle.bold24,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          if (_specificCategoryController
                              .specificCategories[categoryIndex]
                              .listings
                              .isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("You have no listing"),
                              ),
                            ),

                          if (_specificCategoryController
                              .specificCategories[categoryIndex]
                              .listings
                              .isNotEmpty)
                            SizedBox(
                              child: CarouselSlider.builder(
                                itemCount: _specificCategoryController
                                    .specificCategories[categoryIndex]
                                    .listings
                                    .length,
                                itemBuilder:
                                    (context, listingIndex, realIndex) {
                                      final listingItem =
                                          _specificCategoryController
                                              .specificCategories[categoryIndex]
                                              .listings[listingIndex];
                                      return GestureDetector(
                                        onTap: () {
                                          if (listingItem.contractWhatsapp) {
                                            _listingWhatsappController
                                                .fetchListingWhatsapp(
                                                  listingItem.id,
                                                );
                                          } else {
                                            _listingController
                                                .fetchListingDetails(
                                                  listingItem.id,
                                                );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SpecificCarauselContainer(
                                            imagePath: listingItem.mainImage,
                                            title: listingItem.name,
                                            location: listingItem.location,
                                            personIcon: AssetPath.personImage,
                                            clockIcon: AssetPath.clockImage,
                                          ),
                                        ),
                                      );
                                    },
                                options: CarouselOptions(
                                  height: 150.h,
                                  autoPlay: true,
                                  enlargeCenterPage: false,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.70,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  onPageChanged: (index, reason) {
                                    _specificCategoryController
                                        .changeSliderIndex(
                                          categoryIndex,
                                          index,
                                        );
                                  },
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
