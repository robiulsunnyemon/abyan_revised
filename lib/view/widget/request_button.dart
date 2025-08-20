

import 'package:flutter/material.dart';

class RequestButton extends StatelessWidget {
  final VoidCallback onTap;
  const RequestButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: ShapeDecoration(
            color: const Color(0xFFC7AE6A) /* Laser-300 */,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                'Request',
                style: TextStyle(
                  color: const Color(0xFF1A1A1A) /* Woodsmoke-950 */,
                  fontSize: 16,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(),
                child: Icon(Icons.arrow_forward,color: Colors.black87,size: 20,),
              ),
            ],
          ),
        ),
      )
    );
  }

}
