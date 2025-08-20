
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
              color: const Color(0xFF1A1A1A),
              fontSize: 16,
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormField(
            readOnly: isReadOnly,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:BorderSide(
                  width: 1,
                  color: const Color(0xFFDFD2A9) /* Laser-200 */,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:BorderSide(
                  width: 1,
                  color: const Color(0xFFDFD2A9) /* Laser-200 */,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:BorderSide(
                  width: 1,
                  color: const Color(0xFFDFD2A9) /* Laser-200 */,
                ),
              ),
              fillColor: Colors.transparent,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: const Color(0xFF6D6D6D),
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
