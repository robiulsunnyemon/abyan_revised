import 'package:abyansf_asfmanagment_app/controller/mini_sub_category_controller/mini_sub_category_controller.dart';
import 'package:abyansf_asfmanagment_app/models/event_upcoming_model/event_upcoming_model.dart';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/hotel_and_vilas.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/jets_form.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/super_car_screen.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/yacht_form.dart';
import 'package:abyansf_asfmanagment_app/view/screens/constant/constans.dart';
import 'package:abyansf_asfmanagment_app/view/screens/main_screen/explore_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_event_widget.dart';
import 'package:abyansf_asfmanagment_app/view/widget/home_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../api_services/api_urls/api_urls.dart';
import '../../../controller/contact_whatsapp_controller/contact_whatsapp_controller.dart';
import '../../../controller/event_controller/event_controller.dart';
import '../../../controller/highlight_controller/highlight_controller.dart';
import '../../../controller/listing_controller/listing_controller.dart';
import '../../../controller/specific_category_controller/specific_category_controller.dart';
import '../../../controller/sub_category_controller/sub_category_controller.dart';
import '../../../view_models/controller/carousel_controller.dart';
import '../../widget/home_caousel_widget.dart';
import '../profile_screen/event_history_individual_screen.dart';
import '../single_services_pages/all_upcoming_event_screen.dart';
import 'message_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CarouselSliderControllers _carouselSliderController = Get.put(
    CarouselSliderControllers(),
  );
  final _eventController = Get.put(EventController());
  final _subCategoryController = Get.put(SubCategoryController());
  final highlightController = Get.put(HighlightController());
  final _specificCategoryController = Get.put(SpecificCategoryController());
  final _contactWhatsappController = Get.put(ContactWhatsappController());
  final _listingController = Get.put(ListingDetailController());
  final _miniSubCategoryController = Get.put(MiniSubCategoryController());

  Future<void> _onRefresh() async {
    await _subCategoryController.fetchSubCategories();
    await highlightController.fetchHighlights();
    await _eventController.fetchUpcomingEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeAppBar(),
                const SizedBox(height: 20),
                Text('Services', style: AppTextStyle.bold24),
                const SizedBox(height: 7),
                Obx(() {
                  if (_subCategoryController.subCategories.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("You have no service"),
                      ),
                    );
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 0.68,
                      ),
                      itemCount:
                          _subCategoryController.subCategories.length + 1,
                      // +1 for "More"
                      itemBuilder: (context, index) {
                        if (index ==
                            _subCategoryController.subCategories.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.offAll(
                                      () => CustomBottomBar(initialIndex: 2),
                                      transition: Transition.fadeIn,
                                      duration: const Duration(milliseconds: 0),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.network(
                                      "https://cdn.getyourguide.com/image/format=auto,fit=crop,gravity=auto,quality=60,width=450,height=450,dpr=2/tour_img/6dd39f96e4249857.jpeg",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.width / 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'More',
                                  style: AppTextStyle.bold14.copyWith(
                                    fontFamily: 'copperplategothic',
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_subCategoryController
                                      .subCategories[index]
                                      .contractWhatsapp) {
                                    _contactWhatsappController
                                        .fetchServiceDetails(
                                          _subCategoryController
                                              .subCategories[index]
                                              .id,
                                        );
                                    Get.to(() => MassageScreen());
                                  }
                                  if (_subCategoryController
                                      .subCategories[index]
                                      .hasSpecificCategory) {
                                    _specificCategoryController
                                        .fetchSubcategoryDetails(
                                          _subCategoryController
                                              .subCategories[index]
                                              .id,
                                        );
                                  }
                                  if (_subCategoryController
                                      .subCategories[index]
                                      .hasForm) {
                                    if (_subCategoryController
                                            .subCategories[index]
                                            .fromName ==
                                        "Jets") {
                                      Get.to(
                                        () => JetsScreen(
                                          id: _subCategoryController
                                              .subCategories[index]
                                              .id,
                                        ),
                                      );
                                    } else if (_subCategoryController
                                            .subCategories[index]
                                            .fromName ==
                                        "Hotel & Villas") {
                                      Get.to(
                                        () => HotelAndVillasScreen(
                                          id: _subCategoryController
                                              .subCategories[index]
                                              .id,
                                        ),
                                      );
                                    } else if (_subCategoryController
                                            .subCategories[index]
                                            .fromName ==
                                        "Yacht") {
                                      Get.to(
                                        () => YachtRequestFormScreen(
                                          id: _subCategoryController
                                              .subCategories[index]
                                              .id,
                                        ),
                                      );
                                    } else if (_subCategoryController
                                            .subCategories[index]
                                            .fromName ==
                                        "Super Car") {
                                      Get.to(
                                        () => SuperCarScreen(
                                          id: _subCategoryController
                                              .subCategories[index]
                                              .id,
                                        ),
                                      );
                                    }
                                  }
                                  if (_subCategoryController
                                      .subCategories[index]
                                      .hasMiniSubCategory) {
                                    _miniSubCategoryController
                                        .fetchMiniSubCategories(
                                          _subCategoryController
                                              .subCategories[index]
                                              .id,
                                        );
                                  }
                                },
                                child: ClipRRect(
                                  //api theke asche
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.network(
                                    _subCategoryController
                                            .subCategories[index]
                                            .img ??
                                        ApiUrls.defaultImageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.width / 2,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _subCategoryController
                                    .subCategories[index]
                                    .name,
                                style: AppTextStyle.bold12.copyWith(
                                  fontFamily: 'copperplategothic',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
                Text('Highlights', style: AppTextStyle.bold24),
                const SizedBox(height: 13),

                /// Carousel Section
                Obx(() {
                  if (highlightController.highlightsList.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "You have no highlight",
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    );
                  } else {
                    return CarouselSlider.builder(
                      itemCount: highlightController.highlightsList.length,
                      itemBuilder: (context, index, realIndex) {
                        final highlight =
                            highlightController.highlightsList[index];
                        print(
                          'Highlights length: ${highlightController.highlightsList.length}',
                        );

                        return GestureDetector(
                          onTap: () {
                            UpcomingEvent event = UpcomingEvent(
                              id: highlight.event!.id,
                              title: highlight.event!.title,
                              eventImg: highlight.event!.eventImg,
                              date: highlight.event!.date,
                              time: highlight.event!.time,
                              description: highlight.event!.description,
                              maxPerson: highlight.event!.maxPerson,
                              location: highlight.event!.location,
                              status: highlight.event!.status,
                              createdAt: highlight.event!.createdAt,
                              updatedAt: highlight.updatedAt,
                            );

                            Get.to(
                              () => EventHistoryIndividualPage(
                                event: event,
                                eventList: _eventController.upcomingEvents,
                              ),
                            );
                          },
                          child: HomeCarouselWidget(
                            imagePath:
                                highlight.event?.eventImg ??
                                AppConstants.defaultImageUrl,
                            title: highlight.event?.title ?? "Default Name",
                            location:
                                highlight.event?.location ?? "Unknown Location",
                            personIcon: AssetPath.personImage,
                            clockIcon: AssetPath.clockImage,
                          ),
                        );
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
                    );
                  }
                }),

                SizedBox(height: 8),

                /// Carousel Indicator
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      highlightController.highlightsList.length,
                      (index) {
                        final isActive =
                            _carouselSliderController.currentIndex.value ==
                            index;
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
                      },
                    ),
                  );
                }),

                const SizedBox(height: 20),
                /*Row(
                  children: [
                    Text('Member Events', style: AppTextStyle.bold24),
                    const Spacer(),
                    if (_eventController.upcomingEvents.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => CustomBottomBar(initialIndex: 1),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                                (route) => false,
                          );
                        },
                        child: Text(
                          'See all',
                          style: AppTextStyle.bold16.copyWith(
                            fontFamily: "PlayfairDisplay",
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
                        child: Image.asset(AssetPath.noEventImage,scale: 4,)
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
                }),*/
              ],
            ),
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
