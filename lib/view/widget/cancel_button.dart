


import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {


  final VoidCallback onTap;
  const CancelButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.75,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: const Color(0xFFDFD2A9)
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              'Cancel',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1A1A1A) /* Woodsmoke-950 */,
                fontSize: 16,
                fontFamily: 'PlayfairDisplay',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


