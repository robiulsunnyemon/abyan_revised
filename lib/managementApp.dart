
import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/view/auth/resendOTPScreen.dart';
import 'package:abyansf_asfmanagment_app/view/auth/recovery_verification_screen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/main_screen/error_handling_screen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/splash_creen/splash_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManagementApp extends StatelessWidget {
  final Widget widget;
   const ManagementApp({super.key, required this.widget});



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        // if (AuthPrefService.hasToken()) {
        //   print("hasToken");
        //   return CustomBottomBar();
        // } else {
        //   print("has splash");
        //   return SplashScreen();
        // }

        return widget;
      },
    );
  }
}



