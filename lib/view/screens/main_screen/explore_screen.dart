import 'package:abyansf_asfmanagment_app/controller/contact_whatsapp_controller/contact_whatsapp_controller.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/main_category_controller/main_category_controller.dart';
import '../../../controller/mini_sub_category_controller/mini_sub_category_controller.dart';
import '../../../controller/specific_category_controller/specific_category_controller.dart';
import '../../../models/main_category_model/main_category_model.dart';
import '../all_form_pages/hotel_and_villas_screeen.dart';
import '../all_form_pages/jets_screen.dart';
import '../all_form_pages/super_car_screen.dart';
import '../all_form_pages/yacht_request_form_screen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final _mainCategoryController = Get.put(MainCategoryController());
  final _specificCategoryController = Get.put(SpecificCategoryController());
  final _contactWhatsappController = Get.put(ContactWhatsappController());
  final _miniSubCategoryController = Get.put(MiniSubCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 16, left: 0, right: 0, bottom: 8),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Explore", style: AppTextStyle.bold24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: _mainCategoryController.mainCategories.length,
              itemBuilder: (context, index) {
                MainCategory mainCategory =
                    _mainCategoryController.mainCategories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          mainCategory.name,
                          style: AppTextStyle.bold24,
                        ),
                      ),
                      SizedBox(height: 10),
                      if (mainCategory.subCategories.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text('No subcategories found')),
                        ),
                      if (mainCategory.subCategories.isNotEmpty)
                        GridView.builder(
                          itemCount: mainCategory.subCategories.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 14.0,
                                childAspectRatio: 0.72,
                              ),
                          itemBuilder: (context, index) {
                            SubCategory subCategory =
                                mainCategory.subCategories[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 160,
                                  width: 220,
                                  child: GestureDetector(
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
                                        if(subCategory.fromName=="Jets"){
                                          Get.to(()=>JetsScreen(
                                            subCategoryId: subCategory.id,
                                          ));
                                        }
                                        else if(subCategory.fromName=="Hotel & Villas"){
                                          Get.to(()=>HotelAndVillasScreen(subCategoryId:subCategory.id,));
                                        }
                                        else if(subCategory.fromName=="Yacht"){
                                          Get.to(()=>YachtRequestFormScreen(
                                            subCategoryId: subCategory.id,
                                          ));
                                        }
                                        else if(subCategory.fromName=="Super Car"){
                                          Get.to(()=>SuperCarScreen(
                                            subCategoryId: subCategory.id,
                                          ));
                                        }


                                      } else if (subCategory
                                          .hasMiniSubCategory) {
                                        _miniSubCategoryController
                                            .fetchMiniSubCategories(
                                              subCategory.id,
                                            );
                                      }
                                    },
                                    child:  SizedBox(
                                      height: 169,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(subCategory.img,fit: BoxFit.cover,),
                                      ),
                                    ),



                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
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
            ),
          ],
        ),
      ),
    );
  }
}
