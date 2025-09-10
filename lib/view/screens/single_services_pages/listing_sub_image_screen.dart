import 'package:abyansf_asfmanagment_app/models/listting_details_model/listing_details_model.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../utils/assets_path.dart';

class ListingSubImageScreen extends StatelessWidget {
  final ListingDetailData listingDetailData;

  const ListingSubImageScreen({super.key, required this.listingDetailData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(title: listingDetailData.name),
            ),
            SliverList.builder(
              itemCount: listingDetailData.subImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            listingDetailData.subImages[index],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment(0.8, 0.9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.not_listed_location_sharp,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  Text(
                                    'Down town Residence',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AssetPath.personImage,
                                    width: 30,
                                    height: 30,
                                  ),
                                  Image.asset(
                                    AssetPath.clockImage,
                                    width: 30,
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

/*
Stack(
                    children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(listingDetailData.subImages[index],fit: BoxFit.fitHeight,height: 300,),
                        ),
                        Align(
                          alignment: Alignment(0.8, 0.9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.not_listed_location_sharp,color: Colors.white,size: 16,),
                                    Text(
                                      'Down town Residence',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.asset(AssetPath.personImage, width: 30,height: 30,),
                                    Image.asset(AssetPath.clockImage, width: 30,height: 30,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
*/
