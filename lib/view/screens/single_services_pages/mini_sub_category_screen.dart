import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/contact_whatsapp_controller/contact_whatsapp_controller.dart';
import '../../../controller/mini_sub_category_controller/mini_sub_category_controller.dart';
import '../../../controller/mini_sub_whatsapp_api_services/mini_sub_whatsapp_api_services.dart';
import '../../../controller/specific_category_controller/specific_category_controller.dart';
import '../../../utils/style/appColor.dart';
import '../../new_form_list/jets_form.dart';
import '../constant/constans.dart';

class MiniSubCategoryScreen extends StatelessWidget {
  final int subCategoryId;

  MiniSubCategoryScreen({super.key, required this.subCategoryId});

  final _specificCategoryController = Get.put(SpecificCategoryController());
  final _miniSubCategoryController = Get.put(MiniSubCategoryController());
  final _miniSubWhatsappApiServicesController = Get.put(ServiceController());

  Future<void> _onRefresh() async {
    print("called");
    _miniSubCategoryController.fetchMiniSubCategories(subCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Scaffold(
        /*appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.goldenTextColor,
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_left_outlined,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.white,
        ),*/
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      _miniSubCategoryController.miniSubCategories[0].img  ??
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
                        child: Icon(
                          Icons.keyboard_arrow_left_outlined,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(16),
                // Add padding
                itemCount: _miniSubCategoryController.miniSubCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 213,
                  crossAxisSpacing: 10, // Add spacing between items
                  mainAxisSpacing: 13, // Add spacing between rows
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: 169,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Important
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_miniSubCategoryController
                                .miniSubCategories[index]
                                .contractWhatsapp) {
                              print(
                                "${_miniSubCategoryController.miniSubCategories[index].id}",
                              );

                              _miniSubWhatsappApiServicesController
                                  .fetchServiceDetails(
                                    _miniSubCategoryController
                                        .miniSubCategories[index]
                                        .id,
                                  );
                            }
                            if (_miniSubCategoryController
                                .miniSubCategories[index]
                                .hasForm) {
                              if (_miniSubCategoryController
                                      .miniSubCategories[index]
                                      .fromName ==
                                  "Jets") {
                                Get.to(
                                  () => JetsScreen(
                                    id: _miniSubCategoryController
                                        .miniSubCategories[index]
                                        .id,
                                  ),
                                );
                              } else if (_miniSubCategoryController
                                      .miniSubCategories[index]
                                      .fromName ==
                                  "") {
                              } else if (_miniSubCategoryController
                                      .miniSubCategories[index]
                                      .fromName ==
                                  "") {
                              } else if (_miniSubCategoryController
                                      .miniSubCategories[index]
                                      .fromName ==
                                  "") {}
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              _miniSubCategoryController
                                  .miniSubCategories[index]
                                  .img,
                              width: double.infinity,
                              height: 169,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8), // Add spacing
                        Text(
                          _miniSubCategoryController
                              .miniSubCategories[index]
                              .name,
                          style: AppTextStyle.bold16,
                          maxLines: 1, // Prevent text overflow
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
