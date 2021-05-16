import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/screen/resetpassword/resetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  final dController = Get.put(ResetController());
  final emailController = TextEditingController();

  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                  Color(Helper.getHexToInt("#11C7A1")),
                  // Colors.green[600],
                  Color(Helper.getHexToInt("#11E4A1"))
                ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
              text('reset_password'),
              style: TextStyle(
                  fontFamily: 'Poppinsm', fontSize: 18.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: Container(
            color: cardbackgroundColor,
            width: MediaQuery.of(context).size.width,
            child: ListView(children: [
              // Container(
              //     height: 60,
              //     margin: EdgeInsets.only(bottom: 10),
              //     padding:
              //         EdgeInsets.only(top: 25, left: 20, right: 10, bottom: 0),
              //     child: Text(
              //       "Restaurant Offer",
              //       style: TextStyle(
              //           fontFamily: "Poppins",
              //           fontSize: 16,
              //           color: Color(Helper.getHexToInt("#22242A"))),
              //     )),
              promotionsimage(),
              Container(
                height: 30,
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  text('reset_password'),
                  style: TextStyle(
                      fontFamily: "TTCommonsr", fontSize: 20, color: black),
                ),
              ),
              Container(
                height: 60,
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  text('if_you_forgot_your_password'),
                  style: TextStyle(
                      fontFamily: "Poppinsr",
                      fontSize: 14,
                      color: Color(Helper.getHexToInt("#778191"))),
                ),
              ),
              sentEmail(),
              SizedBox(
                height: 40,
              ),
              sendButton(),
            ])));
  }

  Widget promotionsimage() {
    return Container(
      width: Get.width,
      height: 280,
      padding: EdgeInsets.only(top: 20),
      // padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Image.asset(
        'assets/icons/resetimg.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget sendButton() {
    return Container(
      height: 100.0,
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                dController.resetPassword(emailController.text);
                // Get.to(Verification());
              },
              child: Container(
                height: 70,
                // margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                    Color(Helper.getHexToInt("#11C7A1")),
                    // Colors.green[600],
                    Color(Helper.getHexToInt("#11E4A1"))
                  ]),
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                    child: Text(
                  text('send'),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'TTCommonsm',
                  ),
                )),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          // InkWell(
          //   child: Container(
          //     alignment: Alignment.topLeft,
          //     // padding: EdgeInsets.only(top: 5, left: 5),
          //     width: 50,
          //     height: 50,
          //     decoration: BoxDecoration(
          //         gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          //           Color(Helper.getHexToInt("#11C7A1")),
          //           // Colors.green[600],
          //           Color(Helper.getHexToInt("#11E4A1"))
          //         ]),
          //         borderRadius: BorderRadius.circular(9)),
          //     child: Center(child: Image.asset("assets/icons/starw.png")),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget sentEmail() {
    return Container(
      height: 80,
      width: Get.width,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 2, color: Color(Helper.getHexToInt("#F0F0F0")))),
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              bottom: 10,
              child: Container(
                  height: 30,
                  width: 21,
                  child: Obx(() => Icon(
                        dController.same.value
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        // Icons.radio_button_unchecked,
                        color: Color(Helper.getHexToInt("#00E9A3")),
                      ))),
            ),
            Positioned(
              top: 24,
              left: 86,
              child: Center(
                child: Container(
                  child: Text(
                    text('via_email'),
                    style: TextStyle(
                        fontFamily: "TTCommonsr", fontSize: 13, color: black),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 28,
                left: 86,
                child: Container(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: text('mail_hint'),
                      hintStyle: TextStyle(
                        color: Color(Helper.getHexToInt("#636573"))
                            .withOpacity(.5)
                            .withOpacity(.5),
                        fontSize: 16.0,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      dController.checkEmail(text);
                      print("First text field: $text");
                      // print(text.length);
                    },
                    controller: emailController,
                  ),
                )),
            Positioned(
              top: 0,
              bottom: 0,
              left: 15,
              child: Center(
                child: Container(
                  alignment: Alignment.topLeft,
                  // padding: EdgeInsets.only(top: 5, left: 5),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Color(Helper.getHexToInt("#00E9A3"))),
                      borderRadius: BorderRadius.circular(9)),
                  child: Center(child: Image.asset("assets/icons/email.png")),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
