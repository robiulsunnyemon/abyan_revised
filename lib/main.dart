import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/utils/style/themdata.dart';
import 'package:abyansf_asfmanagment_app/view/screens/splash_creen/splash_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app_bindings.dart';
import 'managementApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthPrefService.init();
  await ScreenUtil.ensureScreenSize();
  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AppBindings(),
        theme: themeData(),
        home: AuthPrefService.hasToken() ? ManagementApp(widget: CustomBottomBar()) : ManagementApp(widget: SplashScreen()),
      )
  );
}
