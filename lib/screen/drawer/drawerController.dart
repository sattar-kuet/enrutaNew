import 'package:enruta/controllers/loginController/loginController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerController extends GetxController {
  var userName = ''.obs;
  var email = ''.obs;
  var profileImage=''.obs;

  LoginController loginCont = Get.find();

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  void getUserInfo() async {
    SharedPreferences spreferences = await SharedPreferences.getInstance();

    userName.value = spreferences.get("name");
    email.value = spreferences.get("email");
    profileImage.value= spreferences.get("profileImage");
    if(loginCont.currentUser !=null){
      userName.value= loginCont.currentUser.displayName;
      email.value = loginCont.currentUser.email;
      profileImage.value= loginCont.currentUser.photoUrl;
    }



  }
}
