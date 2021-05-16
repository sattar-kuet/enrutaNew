import 'dart:convert';

import 'package:enruta/screen/login.dart';
import 'package:enruta/screen/resetpassword/newpassword.dart';
import 'package:enruta/screen/resetpassword/verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetController extends GetxController {
  var userName = ''.obs;
  var email = ''.obs;
  final cod1 = TextEditingController().obs;
  final cod2 = TextEditingController().obs;
  final cod3 = TextEditingController().obs;
  final cod4 = TextEditingController().obs;
  final cod5 = TextEditingController().obs;
  final cod6 = TextEditingController().obs;
  var pimage = ''.obs;
  var signupimage = ''.obs;
  var same = false.obs;
  var code = ''.obs;

  RxBool isHidden1 = true.obs;
  var a1 = ''.obs;

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  Future<void> reset() async {
    SharedPreferences spreferences = await SharedPreferences.getInstance();
    spreferences.remove("profileImage");
    spreferences.reload();
  }

  void changeicon() {
    isHidden1.value = !isHidden1.value;
  }

  void checkEmail(var val) {
    print(val);
    print(email.value);
    if (val == email.value) {
      same.value = true;
    } else {
      same.value = false;
    }
  }

  void getUserInfo() async {
    SharedPreferences spreferences = await SharedPreferences.getInstance();

    userName.value = spreferences.get("name");
    email.value = spreferences.get("email");
    pimage.value = spreferences.get("profileImage");
    signupimage.value = spreferences.get("image");
  }

  void resetPassword(String email) async {
    var convertedDatatojson;
    try {
      String url =
          'http://enruta.itscholarbd.com/api/v2' + '/passwordResetRequest';
      final response = await http.post(url,
          headers: {"Accept": "Application/json"}, body: {'email': email});
      convertedDatatojson = jsonDecode(response.body);
      var result = await convertedDatatojson['status'];
      var codes = await convertedDatatojson['code'];
      code.value = codes;
      if (result == 1 && result != null) {
        Get.to(Verification());
      } else {
        Get.snackbar("email not in our service ", "",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("input valid email ", e.message,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void checkverificationCode() {
    var p =
        "${cod1.value.text}${cod2.value.text}${cod3.value.text}${cod4.value.text}${cod5.value.text}${cod6.value.text}";
    // print(p);
    // print(code.value.toString());
    if (code.value == p) {
      Get.to(NewPassword());
    } else {
      Get.snackbar(" ", "your verify code dose not match");
    }
  }

  List<TextEditingController> textFieldControllers;

  void getotp(var t) {
    // Get.snackbar("$t", "ttttt");
  }

  void setPassword(var pass) async {
    // http://enruta.itscholarbd.com/api/v2/

    var convertedDatatojson;
    try {
      String url = 'http://enruta.itscholarbd.com/api/v2' + '/resetPassword';
      final response = await http.post(url,
          headers: {"Accept": "Application/json"},
          body: {'code': code.value, 'password': pass});
      convertedDatatojson = jsonDecode(response.body);
      var result = await convertedDatatojson['status'];
      // var codes = await convertedDatatojson['code'];
      // code.value = codes;
      if (result == 1 && result != null) {
        // Get.to(Verification());
        Get.offAll(LoginPage());
      } else {
        Get.snackbar("password not set ", "",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("input valid email ", e.message,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
