
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:flutter/material.dart';

class CustomTextEditingFormField extends StatelessWidget {
  final String headingText;
  final String hintText;
  final TextEditingController controller;
  final bool isReadOnly;
  const CustomTextEditingFormField({super.key,this.isReadOnly=false,required this.headingText, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 7,
        children: [
          Text(
            headingText,
            style: TextStyle(
              color: AppColors.goldenTextColor,
              fontSize: 16,
              fontFamily: 'copperplategothic',
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormField(
            readOnly: isReadOnly,
            controller: controller,
            style:TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:BorderSide(
                  width: 1,
                  color: AppColors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:BorderSide(
                  width: 1,
                  color: AppColors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:BorderSide(
                  width: 1,
                  color: AppColors.white,
                ),
              ),
              fillColor: Colors.transparent,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.hintWhiteColor,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
