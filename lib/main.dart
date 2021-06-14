// ignore: unused_import
import 'package:enruta/controllers/cartController.dart';
import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/controllers/loginController/loginBinding.dart';
import 'package:enruta/screen/getReview/getReview.dart';
import 'package:enruta/screen/homePage.dart';
import 'package:enruta/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: unused_import
import 'controllers/textController.dart';
import 'helper/helper.dart';
import 'package:firebase_core/firebase_core.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(Helper.getHexToInt("#11C7A1")),
      unselectedWidgetColor: Color(Helper.getHexToInt("#6F6F6F")),
    ),
    initialBinding: LoginBinding(),
    // defaultTransition: Transition.fade,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GoogleSignInAccount currentUser;

  @override
  void initState() {
    super.initState();
    Get.put(LanguageController());
    Future.delayed(Duration(seconds: 3), () async {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginPage()));
      // googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      //   setState(() {
      //     currentUser = account;
      //   });
      // });
      // if (currentUser != null) {
      //   googleSignIn.signInSilently();
      // }

      checkloginstutas();
    });
  }

  void checkloginstutas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    var email = prefs.getString('email');
    // var email = prefs.getString('email');
    int islogin = prefs.getInt('islogin');
    var checkLogin = prefs.getString("checkLogin");
    var orderComplete = prefs.getInt("OrderCompletedShop");
    print("islogin");
    print(islogin);
    if (islogin == null) {
      islogin = 0;
    }
    print(islogin);
    // islogin ==1?Get.offAll(HomePage()):Get.offAll(LoginPage());
    if (checkLogin == "a") {
      // Get.put(TestController());
      // Get.put(CartController());
      await Geolocator().getCurrentPosition();
      var permission = await Geolocator().checkGeolocationPermissionStatus();
      if (permission != GeolocationStatus.denied) {
        if (orderComplete != null) {
          Get.to(GetReviewPage(orderComplete));
        } else {
          Get.offAll(HomePage());
        }
      } else {
        Get.defaultDialog(title: "Please give Permission first");
      }
    } else {
      Get.offAll(LoginPage());
    }

    // if (islogin == 1) {
    //   Get.offAll(HomePage());
    // } else {
    //   Get.offAll(LoginPage());
    // }

    // if (email == null) {
    //   print(email);
    //   Get.offAll(LoginPage());
    //   // Navigator.pushAndRemoveUntil(
    //   //   context,
    //   //   MaterialPageRoute(builder: (context) => LoginPage()),
    //   //   (Route<dynamic> route) => false,
    //   // );
    // } else {
    //   Get.offAll(HomePage());
    //   // Navigator.pushAndRemoveUntil(
    //   //   context,
    //   //   MaterialPageRoute(builder: (context) => HomePage()),
    //   //   (Route<dynamic> route) => false,
    //   // );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: 300.0,
                  child: Image.asset(
                    "assets/images/Enruta-Logo.png",
                    height: 100,
                    width: 150,
                    // fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
