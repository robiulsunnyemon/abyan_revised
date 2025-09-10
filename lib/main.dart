import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/utils/style/themdata.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/beach_club.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/dining_club.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/jets_form.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/night_life_club.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/super_car_screen.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/willness_form.dart';
import 'package:abyansf_asfmanagment_app/view/new_form_list/yacht_form.dart';
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
        // home: await AuthPrefService.isTokenValid()? ManagementApp(widget: CustomBottomBar()) : ManagementApp(widget: SplashScreen()),
        home: ManagementApp(widget: DiningForm())


      )
  );
}
