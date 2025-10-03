import 'package:abyansf_asfmanagment_app/models/listting_details_model/listing_details_model.dart';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatelessWidget {
  final ListingDetailData listingDetailData;

  const MenuScreen({super.key, required this.listingDetailData});

  @override
  Widget build(BuildContext context) {
    print("--------------${listingDetailData.name}");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CustomAppBar(title: "Menu"),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 40.h),
              ),
              //will be change when api work
              SliverToBoxAdapter(
                child: Image.asset(
                  AssetPath.menuList,
                  fit: BoxFit.fitWidth, // width full, height auto
                  width: double.infinity,
                ),
              ),
              /*SliverList.builder(
                itemCount: listingDetailData.menuImages.length,
                itemBuilder: (context, index) {
                  print("--------------${listingDetailData.menuImages[index]}");
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: Image.network(
                          listingDetailData.menuImages[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
