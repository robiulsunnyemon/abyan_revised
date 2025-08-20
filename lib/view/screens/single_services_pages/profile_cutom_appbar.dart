import 'package:flutter/material.dart';

import '../../../utils/style/appColor.dart';
import '../../../utils/style/app_text_styles.dart';

class ProfileCustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? action;
  final bool showBack;

  const ProfileCustomAppbar({
    super.key,
    required this.title,
    this.action,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          showBack
              ? GestureDetector(
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
              ),
            ),
          )
              : const SizedBox(width: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: AppTextStyle.bold24,maxLines: 1,),
                    ],
                  )
              ),
            ],
          ),
          action ?? const SizedBox(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);
}
