import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/login_api_services/login_api_services.dart';
import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final TextEditingController emailTEController=TextEditingController();
  final TextEditingController passwordTEController=TextEditingController();


  Future<void> login({required String email,required String password}) async {
    try{
      final response=await LoginApiServices.loginPostRequest(email: email, password: password);

      print(response.statusCode);

      if(response.statusCode==200){
        final decodedResponse=jsonDecode(response.body);
        final String token=decodedResponse['token'];
        AuthPrefService.saveToken(token);
        Get.offAll(()=>CustomBottomBar());
      }
      else{
        Get.snackbar("Error", "Your Password or Email is wrong");
      }
    }catch(e){
      print(e.toString());
    }
  }
}