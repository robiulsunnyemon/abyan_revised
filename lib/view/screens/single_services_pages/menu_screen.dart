import 'package:abyansf_asfmanagment_app/models/listting_details_model/listing_details_model.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final ListingDetailData listingDetailData;
  const MenuScreen({super.key, required this.listingDetailData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomAppBar(title: "Menu")),
            SliverList.builder(
              itemCount: listingDetailData.menuImages.length,
              itemBuilder: (context, index) {
                print(listingDetailData.menuImages[index]);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Image.network(listingDetailData.menuImages[index],fit: BoxFit.fill,),
                  ),
                ),
              );
            },)
          ],
        ),
      ),
    );
  }
}
