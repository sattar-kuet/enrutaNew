import 'dart:convert';
import 'dart:io';

import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/screen/bottomnavigation/bottomNavigation.dart';
import 'package:enruta/screen/drawer/myDrawerPage.dart';
import 'package:enruta/screen/paymentmethods.dart';
import 'package:enruta/screen/promotion/promotion.dart';
import 'package:enruta/screen/resetpassword/resetController.dart';
import 'package:enruta/screen/setLocation.dart';
import 'package:enruta/screen/voucher/myvoucher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'myaccountController.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final dController = Get.put(
    ResetController(),
  );

  final language = Get.put(LanguageController());

  String text(String key) {
    return language.text(key);
  }

  File imageF;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyAccountController());

    return Scaffold(
        drawer: MyDrawerPage(),
        body: Container(
            child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height / 8,
                  height: 195,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, colors: [
                        Color(Helper.getHexToInt("#11C7A1")),
                        // Colors.green[600],
                        Color(Helper.getHexToInt("#11E4A1"))
                      ]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Container(
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Positioned(
                          top: 56,
                          left: 20,
                          // right: 50,
                          child: Container(
                            width: 103,
                            height: 99,
                            // padding: EdgeInsets.only(left: 10),
                            child: profileImage(context, imageF),
                          ),
                        ),
                        Positioned(
                          top: 65,
                          left: 145,
                          child: Obx(() => Text(
                                controller.name.value,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    color: white),
                              )),
                        ),
                        Positioned(
                          top: 90,
                          left: 145,
                          child: Obx(() => Text(
                                controller.email.value,
                                style: TextStyle(
                                    fontFamily: "Poppinsr",
                                    fontSize: 14,
                                    color: white),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // showMenue(),
                account(),
                SizedBox(height: 1),
                offer(),
                SizedBox(height: 1),
                settings(context),
                SizedBox(height: 1),
                helpandlegal(),
                SizedBox(height: 50),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 73,
            child: BottomNavigation(),
          ),
        ])));
  }

  Widget account() {
    return SafeArea(
      child: Container(
        height: 190,
        margin: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Column(
          children: [
            Container(
                height: 40,
                width: Get.width,
                child: Text(
                  text('account'),
                  style: TextStyle(
                      fontFamily: "Poppinsr",
                      fontSize: 14,
                      color: Color(Helper.getHexToInt("#22242A"))),
                )),
            Container(
                height: 50,
                width: Get.width,
                child: InkWell(
                  onTap: () {
                    Get.to(Paymentmethods());
                  },
                  child: Row(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/pay.png',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            text('payment_method'),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Color(Helper.getHexToInt("#22242A"))),
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.navigate_next,
                          color: Color(Helper.getHexToInt("#CDCDD7")),
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                height: 50,
                width: Get.width,
                child: InkWell(
                  onTap: () {
                    Get.to(SetLocation());
                  },
                  child: Row(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/placec.png',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            text('saved_addresses'),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              color: Color(Helper.getHexToInt("#22242A")),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.navigate_next,
                          color: Color(Helper.getHexToInt("#CDCDD7")),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget offer() {
    return SafeArea(
      child: Container(
        height: 190,
        margin: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Column(
          children: [
            Container(
                height: 40,
                width: Get.width,
                child: Text(
                  text('offer'),
                  style: TextStyle(
                      fontFamily: "Poppinsr",
                      fontSize: 14,
                      color: Color(Helper.getHexToInt("#22242A"))),
                )),
            Container(
                height: 50,
                width: Get.width,
                child: InkWell(
                  onTap: () {
                    Get.to(Promotion());
                  },
                  child: Row(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/shout.png',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            text('promotions'),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Color(Helper.getHexToInt("#22242A"))),
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.navigate_next,
                          color: Color(Helper.getHexToInt("#CDCDD7")),
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                height: 50,
                width: Get.width,
                child: InkWell(
                  onTap: () {
                    Get.to(MyVoucher());
                  },
                  child: Row(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/coupon.png',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            text('get_discount'),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              color: Color(Helper.getHexToInt("#22242A")),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.navigate_next,
                          color: Color(Helper.getHexToInt("#CDCDD7")),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(
    context,
  ) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // ignore: deprecated_member_use
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(
                  ImageSource.camera,
                  context,
                );
              },
              label: Text(text('camera')),
            ),
            // ignore: deprecated_member_use
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery, context);
              },
              label: Text(text('gallery')),
            ),
          ])
        ],
      ),
    );
  }

  bool spin = false;
  var path;
  void takePhoto(ImageSource source, context) async {
    final dController = Get.find<MyAccountController>();
    // ignore: non_constant_identifier_names
    final Controller = Get.find<ResetController>();
    // ignore: deprecated_member_use
    path = await ImagePicker.pickImage(
            source: source, maxHeight: 400, maxWidth: 300)
        .then((value) async {
      print('VALUE = $value');
      setState(() {
        if (value != null) {
          imageF = value;
          print('IMAGE PATH =$imageF');
          profileImage(context, imageF);
        } else {
          print('No image selected.');
        }
      });
      setState(() {
        spin = true;
      });
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "http://enruta.itscholarbd.com/api/v2/updateProfilePicture"));
      print('path = $imageF');
      request.files.add(
          await http.MultipartFile.fromPath('avatar', imageF.path.toString()));
      request.fields['user_id'] = '${dController.id.value}';
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        final response = await http.post(
            Uri.parse('http://enruta.itscholarbd.com/api/v2/getUser'),
            headers: {"Accept": "Application/json"},
            body: {'email': '${dController.email.value}'});
        if (response.statusCode == 200) {
          var avatar = jsonDecode(response.body);
          var i = avatar['user']['avatar']['path'];
          print('RESPONSE === ${avatar['user']['avatar']['path']}');
          // dController.reset();
          SharedPreferences pre = await SharedPreferences.getInstance();
          pre.setString('profileImage', i);

          Navigator.pop(context);
        }
      }
      setState(() {
        Controller.pimage.value;
        spin = false;
      });
    });
  }

  Widget profileImage(context, imageF) {
    print('profile = ${dController.pimage.value}');
    return Center(
      child: ModalProgressHUD(
        inAsyncCall: spin,
        child: ClipOval(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet(
                      context,
                    )),
              );
              print("Container clicked");
            },

            // child:CircleAvatar(
            //   radius: 80.0,
            //   backgroundImage: _imageFile == null
            //       ? AssetImage("assets/images/group4320.png")
            //       : FileImage(File(_imageFile.path)),
            // )
            child: GetImage(imageF),
            // Obx(()=>
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container GetImage(imageF) {
    return Container(
      height: 120,
      width: 120,
      color: Colors.grey.shade200,
      child: CircleAvatar(
          radius: 80.0,
          backgroundImage: imageF != null
              ? FileImage(
                  imageF,
                )
              : dController.pimage.value != null
                  ? NetworkImage('${dController.pimage.value}')
                  : AssetImage('assets/icons/persono.png')),
      // Image.asset(
      //   "assets/images/group4320.png",
      //   width: 120.0,
      //   height: 120.0,
      //   fit: BoxFit.contain,
      // ),
      //
      // imageF == null
      //     ? AssetImage("assets/images/group4320.png")
      //     : FileImage(File(imageF.path)),
    );
  }

  Widget settings(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 190,
        margin: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Column(
          children: [
            Container(
                height: 40,
                width: Get.width,
                child: Text(
                  text('language'),
                  style: TextStyle(
                      fontFamily: "Poppinsr",
                      fontSize: 14,
                      color: Color(Helper.getHexToInt("#22242A"))),
                )),
            Container(
              height: 50,
              width: Get.width,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return languageDialog();
                      });
                },
                child: Row(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/icons/language.png',
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          text('language'),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              color: Color(Helper.getHexToInt("#22242A"))),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        language.currentLanguage,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Color(Helper.getHexToInt("#22242A"))),
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.navigate_next,
                        color: Color(Helper.getHexToInt("#CDCDD7")),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                height: 50,
                width: Get.width,
                child: Row(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/icons/security.png',
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          text('permissions'),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Color(Helper.getHexToInt("#22242A")),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.navigate_next,
                        color: Color(Helper.getHexToInt("#CDCDD7")),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget helpandlegal() {
    return SafeArea(
      child: Container(
        height: 190,
        margin: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Column(
          children: [
            Container(
                height: 40,
                width: Get.width,
                child: Text(
                  text('help_&_legal'),
                  style: TextStyle(
                      fontFamily: "Poppinsr",
                      fontSize: 14,
                      color: Color(Helper.getHexToInt("#22242A"))),
                )),
            Container(
                height: 50,
                width: Get.width,
                child: Row(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/icons/help.png',
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          text('help'),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              color: Color(Helper.getHexToInt("#22242A"))),
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.navigate_next,
                        color: Color(Helper.getHexToInt("#CDCDD7")),
                      ),
                    )
                  ],
                )),
            Container(
                height: 50,
                width: Get.width,
                child: Row(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/icons/polices.png',
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          text('polices'),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Color(Helper.getHexToInt("#22242A")),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.navigate_next,
                        color: Color(Helper.getHexToInt("#CDCDD7")),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class languageDialog extends StatefulWidget {
  languageDialog();

  @override
  _languageDialog createState() => _languageDialog();
}

// ignore: camel_case_types
class _languageDialog extends State {
  _languageDialog();

  bool open = true;

  final language = Get.put(LanguageController());

  String dropdownValue;

  List<String> langs;

  int data = -1;

  @override
  Widget build(BuildContext context) {
    if (open) {
      open = false;
      data = language.currentLanguage == language.english ? 0 : 1;
      langs = [language.english, language.spanish];
    }

    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      backgroundColor: cardbackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      content: Container(
        height: Get.height / 3.25,
        width: Get.width,
        child: Column(
          children: [
            Container(
              height: 50,
              width: Get.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        "Choose language",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'TTCommonsm',
                          color: Color(Helper.getHexToInt("#B0B0B0")),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(
                            Helper.getHexToInt("#F2F2F2"),
                          ),
                          child: Icon(
                            Icons.close_rounded,
                            color: theamColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Center(
                  child: CheckboxListTile(
                    title: Text("English"),
                    value: data == 0,
                    onChanged: (state) {
                      setState(() {
                        data = state ? 0 : data;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                  ),
                ),
                Center(
                  child: CheckboxListTile(
                    title: Text("Spanish"),
                    value: data == 1,
                    onChanged: (state) {
                      setState(() {
                        data = state ? 1 : data;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Container(
          height: 50,
          width: 100,
          margin: EdgeInsets.only(
            right: 25,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                  child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(Helper.getHexToInt("#11C7A1")),
                  //Colors.white,
                  fontFamily: 'TTCommonsm',
                ),
              )),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 155,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
          ),
          child: langs[data] == language.currentLanguage
              ? Container()
              : InkWell(
                  onTap: () {
                    if (langs[data] != language.currentLanguage) {
                      Navigator.pop(context);
                      language.setLanguage(langs[data]);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 155,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          colors: [
                            Color(Helper.getHexToInt("#11C7A1")),
                            Color(Helper.getHexToInt("#11E4A1"))
                          ]),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Center(
                      child: Text(
                        "Save & Restart",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'TTCommonsm',
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
