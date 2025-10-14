import 'package:abyansf_asfmanagment_app/controller/contact_whatsapp_controller/contact_whatsapp_controller.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../api_services/api_urls/api_urls.dart';
import '../../../controller/main_category_controller/main_category_controller.dart';
import '../../../controller/mini_sub_category_controller/mini_sub_category_controller.dart';
import '../../../controller/specific_category_controller/specific_category_controller.dart';
import '../../../models/main_category_model/main_category_model.dart';
import '../../new_form_list/hotel_and_vilas.dart';
import '../../new_form_list/jets_form.dart';
import '../../new_form_list/super_car_screen.dart';
import '../../new_form_list/yacht_form.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final _mainCategoryController = Get.put(MainCategoryController());
  final _specificCategoryController = Get.put(SpecificCategoryController());
  final _contactWhatsappController = Get.put(ContactWhatsappController());
  final _miniSubCategoryController = Get.put(MiniSubCategoryController());

  Future<void> _onRefresh() async {
    await _mainCategoryController.fetchMainCategories();
    _specificCategoryController.specificCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text("Explore", style: AppTextStyle.bold24),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                if (_mainCategoryController.isLoading.value) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return SliverList.builder(
                    itemCount: _mainCategoryController.mainCategories.length,
                    itemBuilder: (context, index) {
                      MainCategory mainCategory =
                      _mainCategoryController.mainCategories[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Text(
                                mainCategory.name,
                                style: AppTextStyle.bold24,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            if (mainCategory.subCategories.isEmpty)
                              Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Center(
                                  child: Text('No subcategories found'),
                                ),
                              ),
                            if (mainCategory.subCategories.isNotEmpty)
                              GridView.builder(
                                itemCount: mainCategory.subCategories.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.w,
                                  childAspectRatio: 0.68,
                                ),
                                itemBuilder: (context, index) {
                                  SubCategory subCategory =
                                  mainCategory.subCategories[index];
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (subCategory.hasSpecificCategory) {
                                            _specificCategoryController
                                                .fetchSubcategoryDetails(
                                              subCategory.id,
                                            );
                                          } else if (subCategory.contractWhatsapp) {
                                            _contactWhatsappController
                                                .fetchServiceDetails(
                                              subCategory.id,
                                            );
                                          } else if (subCategory.hasForm) {
                                            if (subCategory.fromName == "Jets") {
                                              Get.to(() => JetsScreen(
                                                id: subCategory.id,
                                              ));
                                            } else if (subCategory.fromName ==
                                                "Hotel & Villas") {
                                              Get.to(() =>
                                                  HotelAndVillasScreen(
                                                    id: subCategory.id,
                                                  ));
                                            } else if (subCategory.fromName ==
                                                "Yacht") {
                                              Get.to(() => YachtRequestFormScreen(
                                                id: subCategory.id,
                                              ));
                                            } else if (subCategory.fromName ==
                                                "Super Car") {
                                              Get.to(() => SuperCarScreen(
                                                id: subCategory.id,
                                              ));
                                            }
                                          } else if (subCategory.hasMiniSubCategory) {
                                            _miniSubCategoryController
                                                .fetchMiniSubCategories(
                                              subCategory.id,
                                            );
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.r),
                                          child: Image.network(
                                            subCategory.img ??
                                                ApiUrls.defaultImageUrl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height:
                                            MediaQuery.of(context).size.width /
                                                2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Text(
                                          subCategory.name,
                                          style: AppTextStyle.bold16,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
