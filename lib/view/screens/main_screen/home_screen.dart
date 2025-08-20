import 'package:abyansf_asfmanagment_app/controller/mini_sub_category_controller/mini_sub_category_controller.dart';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/jets_screen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/super_car_screen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/yacht_request_form_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_event_widget.dart';
import 'package:abyansf_asfmanagment_app/view/widget/home_appbar.dart';
import 'package:abyansf_asfmanagment_app/view/widget/carousel_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/contact_whatsapp_controller/contact_whatsapp_controller.dart';
import '../../../controller/event_controller/event_controller.dart';
import '../../../controller/highlight_controller/highlight_controller.dart';
import '../../../controller/listing_controller/listing_controller.dart';
import '../../../controller/specific_category_controller/specific_category_controller.dart';
import '../../../controller/sub_category_controller/sub_category_controller.dart';
import '../../../view_models/controller/carousel_controller.dart';
import '../../widget/home_caousel_widget.dart';
import '../all_form_pages/hotel_and_villas_screeen.dart';
import '../single_services_pages/all_upcoming_event_screen.dart';
import 'message_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final CarouselSliderControllers _carouselSliderController = Get.put(CarouselSliderControllers());

  final _eventController = Get.put(EventController());

  final _subCategoryController = Get.put(SubCategoryController());

  final highlightController = Get.put(HighlightController());

  final _specificCategoryController = Get.put(SpecificCategoryController());

  final _contactWhatsappController = Get.put(ContactWhatsappController());

  final _listingController=Get.put(ListingDetailController());

  final _miniSubCategoryController=Get.put(MiniSubCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(),
              const SizedBox(height: 10),
              Text('Services', style: AppTextStyle.bold24),
              const SizedBox(height: 7),
              Obx(
                () => SizedBox(
                  height: 145,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _subCategoryController.subCategories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: (){
                                if(_subCategoryController.subCategories[index].contractWhatsapp){
                                  _contactWhatsappController.fetchServiceDetails(_subCategoryController.subCategories[index].id);
                                  Get.to(()=>MassageScreen());
                                }
                                if(_subCategoryController.subCategories[index].hasSpecificCategory){
                                  _specificCategoryController.fetchSubcategoryDetails(_subCategoryController.subCategories[index].id);
                                }
                                if(_subCategoryController.subCategories[index].hasForm){
                                  if(_subCategoryController.subCategories[index].fromName=="Jets"){
                                    Get.to(()=>JetsScreen(
                                      subCategoryId: _subCategoryController.subCategories[index].id,
                                    ));
                                  }
                                  else if(_subCategoryController.subCategories[index].fromName=="Hotel & Villas"){
                                    Get.to(()=>HotelAndVillasScreen(subCategoryId: _subCategoryController.subCategories[index].id));
                                  }
                                  else if(_subCategoryController.subCategories[index].fromName=="Yacht"){
                                    Get.to(()=>YachtRequestFormScreen(
                                      subCategoryId: _subCategoryController.subCategories[index].id,
                                    ));
                                  }
                                  else if(_subCategoryController.subCategories[index].fromName=="Super Car"){
                                    Get.to(()=>SuperCarScreen(
                                      subCategoryId: _subCategoryController.subCategories[index].id,
                                    ));
                                  }

                                }
                                if(_subCategoryController.subCategories[index].hasMiniSubCategory){
                                  _miniSubCategoryController.fetchMiniSubCategories(_subCategoryController.subCategories[index].id);
                                }
                              },
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  _subCategoryController.subCategories[index].img,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _subCategoryController.subCategories[index].name,
                              style: AppTextStyle.bold14.copyWith(
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Highlight', style: AppTextStyle.bold24),
              const SizedBox(height: 13),

              /// Carousel Section
              Obx(
                    () => CarouselSlider.builder(
                  itemCount: highlightController.highlightsList.length,
                  itemBuilder: (context, index, realIndex) {
                    final highlight =
                    highlightController.highlightsList[index];

                    if(highlight.subCategory!=null){

                      return Padding(
                        padding: const EdgeInsets.all(7),
                        child: GestureDetector(

                          child: HomeCarouselWidget(
                            imagePath: highlight.subCategory!.img,
                            title: highlight.subCategory?.name??"Default Name",
                            location: '',
                            personIcon: AssetPath.personImage,
                            clockIcon: AssetPath.clockImage,
                          ),
                          onTap: (){
                            if(highlight.subCategory!.hasForm){
                              if(highlight.subCategory!.fromName=="Jets"){
                                Get.to(()=>JetsScreen(
                                  subCategoryId: highlight.subCategory!.id,
                                ));
                              }
                              else if(highlight.subCategory!.fromName==""){}
                              else if(highlight.subCategory!.fromName==""){}
                            }
                            if(highlight.subCategory!.contractWhatsapp){
                              _contactWhatsappController.fetchServiceDetails(highlight.subCategory!.id);
                            }
                            if(highlight.subCategory!.hasSpecificCategory){
                              _specificCategoryController.fetchSubcategoryDetails(highlight.subCategory!.id);
                            }
                          },
                        ),
                      );
                    }
                    if(highlight.miniSubCategory!=null){


                      return GestureDetector(
                        child: HomeCarouselWidget(
                          imagePath: highlight.miniSubCategory!.img,
                          title: highlight.miniSubCategory?.name ?? "Default Name",
                          location:"",
                          personIcon: AssetPath.personImage,
                          clockIcon: AssetPath.clockImage,
                        ),
                        onTap: (){
                          if(highlight.miniSubCategory!.hasForm){
                            if(highlight.miniSubCategory!.fromName=="Jets"){
                              Get.to(()=>JetsScreen(
                                subCategoryId: highlight.miniSubCategory!.id,
                              ));
                            }
                            else if(highlight.miniSubCategory!.fromName==""){}
                            else if(highlight.miniSubCategory!.fromName==""){}
                            else if(highlight.miniSubCategory!.fromName==""){}
                            else if(highlight.miniSubCategory!.fromName==""){}

                          }
                          if(highlight.miniSubCategory!.contractWhatsapp){
                            _contactWhatsappController.fetchServiceDetails(highlight.subCategory!.id);
                          }
                          if(highlight.miniSubCategory!.hasSpecificCategory){
                            _specificCategoryController.fetchSubcategoryDetails(highlight.subCategory!.id);
                          }
                        },
                      );



                      return CarouselContainer(
                        isNetworkImage: true,
                        imagePath: highlight.miniSubCategory!.img,
                        title: highlight.miniSubCategory?.name ?? "Default Name",
                        location:"",
                        isLocation: false,
                        personIcon: AssetPath.personImage,
                        clockIcon: AssetPath.clockImage,
                        onTap: (){
                          if(highlight.miniSubCategory!.hasForm){
                            if(highlight.miniSubCategory!.fromName=="Jets"){
                              Get.to(()=>JetsScreen(
                                subCategoryId: highlight.miniSubCategory!.id,
                              ));
                            }
                            else if(highlight.miniSubCategory!.fromName==""){}
                            else if(highlight.miniSubCategory!.fromName==""){}
                            else if(highlight.miniSubCategory!.fromName==""){}
                            else if(highlight.miniSubCategory!.fromName==""){}

                          }
                          if(highlight.miniSubCategory!.contractWhatsapp){
                            _contactWhatsappController.fetchServiceDetails(highlight.subCategory!.id);
                          }
                          if(highlight.miniSubCategory!.hasSpecificCategory){
                            _specificCategoryController.fetchSubcategoryDetails(highlight.subCategory!.id);
                          }

                        },
                      );
                    }
                    if(highlight.listing!=null){

                      return GestureDetector(
                        child: HomeCarouselWidget(

                          imagePath: highlight.listing!.mainImage,
                          title: highlight.listing?.name ?? "Default Name",
                          location: highlight.listing?.location,
                          personIcon: AssetPath.personImage,
                          clockIcon: AssetPath.clockImage,
                        ),
                        onTap: (){
                          if(highlight.listing!.hasForm){

                            if(highlight.listing!.formName=="Jets"){
                              Get.to(()=>JetsScreen(
                                subCategoryId: highlight.listing!.id,
                              ));
                            }
                            else if(highlight.listing?.formName==""){}
                            else if(highlight.listing?.formName==""){}
                            else if(highlight.listing?.formName==""){}
                            else if(highlight.listing?.formName==""){}


                          }
                          if(highlight.listing!.contractWhatsapp){
                            _contactWhatsappController.fetchServiceDetails(highlight.subCategory!.id);
                          }else{
                            _listingController.fetchListingDetails(highlight.listing!.id);

                          }
                        },
                      );



                      return CarouselContainer(
                        isNetworkImage: true,
                        imagePath: highlight.listing!.mainImage,
                        title: highlight.listing?.name ?? "Default Name",
                        location: highlight.listing?.location,
                        personIcon: AssetPath.personImage,
                        clockIcon: AssetPath.clockImage,
                        onTap: (){
                          if(highlight.listing!.hasForm){

                            if(highlight.listing!.formName=="Jets"){
                              Get.to(()=>JetsScreen(
                                subCategoryId: highlight.listing!.id,
                              ));
                            }
                            else if(highlight.listing?.formName==""){}
                            else if(highlight.listing?.formName==""){}
                            else if(highlight.listing?.formName==""){}
                            else if(highlight.listing?.formName==""){}


                          }
                          if(highlight.listing!.contractWhatsapp){
                            _contactWhatsappController.fetchServiceDetails(highlight.subCategory!.id);
                          }else{
                            _listingController.fetchListingDetails(highlight.listing!.id);

                          }

                        },
                      );
                    }
                    return Container();

                  },
                  options: CarouselOptions(
                    height: 220,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.83,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      _carouselSliderController.currentIndex.value = index;
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),




              /// Carousel Indicator
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(highlightController.highlightsList.length, (index) {
                    final isActive =
                        _carouselSliderController.currentIndex.value == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 16 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: isActive
                            ? AppColors.primaryColor
                            : AppColors.lightGrey,
                      ),
                    );
                  }),
                );
              }),

              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Member Event', style: AppTextStyle.bold24),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.to(()=>AllUpcomingEventScreen());
                    },
                    child: Text(
                      'See all',
                      style: AppTextStyle.bold16.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              /// Event List
              Obx(() {
                if (_eventController.upcomingEvents.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("You have no event"),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _eventController.upcomingEvents.length,
                    itemBuilder: (context, index) => CustomEventWidget(
                      event: _eventController.upcomingEvents[index],
                    ),
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

final List<String> images = [
  AssetPath.hotelImage,
  AssetPath.splashScreen2,
  AssetPath.splashScreen3,
];
