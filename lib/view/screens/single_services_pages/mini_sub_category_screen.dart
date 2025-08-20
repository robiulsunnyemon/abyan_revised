import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/contact_whatsapp_controller/contact_whatsapp_controller.dart';
import '../../../controller/mini_sub_category_controller/mini_sub_category_controller.dart';
import '../../../utils/style/appColor.dart';
import '../all_form_pages/jets_screen.dart';

class MiniSubCategoryScreen extends StatelessWidget {
  MiniSubCategoryScreen({super.key});

  final _miniSubCategoryController = Get.put(MiniSubCategoryController());
  final _contactWhatsappController = Get.put(ContactWhatsappController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                    color: AppColors.greyBackgroundColor,
                  ),
                  child: const Icon(Icons.keyboard_arrow_left_outlined),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),  // Add padding
        itemCount: _miniSubCategoryController.miniSubCategories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 213,
          crossAxisSpacing: 10,  // Add spacing between items
          mainAxisSpacing: 13,    // Add spacing between rows
        ),
        itemBuilder: (context, index) {
          return Container(
            width: 169,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,  // Important
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    if(_miniSubCategoryController.miniSubCategories[index].contractWhatsapp){
                      _contactWhatsappController.fetchServiceDetails(_miniSubCategoryController.miniSubCategories[index].id);
                    }
                    if(_miniSubCategoryController.miniSubCategories[index].hasForm){
                      if(_miniSubCategoryController.miniSubCategories[index].fromName=="Jets"){
                        Get.to(()=>JetsScreen(
                          subCategoryId: _miniSubCategoryController.miniSubCategories[index].id,
                        ));
                      }
                      else if(_miniSubCategoryController.miniSubCategories[index].fromName==""){}
                      else if(_miniSubCategoryController.miniSubCategories[index].fromName==""){}
                      else if(_miniSubCategoryController.miniSubCategories[index].fromName==""){}

                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      _miniSubCategoryController.miniSubCategories[index].img,
                      width: double.infinity,
                      height: 169,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8),  // Add spacing
                Text(
                  _miniSubCategoryController.miniSubCategories[index].name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Playfair Display',
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,  // Prevent text overflow
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}