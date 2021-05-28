import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';

import 'package:enruta/screen/resetpassword/resetController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Verification extends StatelessWidget {
  final resetController = Get.put(ResetController());
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> textFieldControllers = [];

  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final node = FocusScope.of(context);
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
        title: Text(text('verification_code'),
            style: TextStyle(
                fontFamily: 'Poppinsm', fontSize: 18.0, color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
          color: cardbackgroundColor,
          width: MediaQuery.of(context).size.width,
          child: ListView(children: [
            Container(
              height: 200,
              width: 200,
              child: verificationimage(),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              // width: 200,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    inputCode(context, 0, resetController.cod1.value),
                    inputCode(context, 1, resetController.cod2.value),
                    inputCode(context, 2, resetController.cod3.value),
                    inputCode(context, 3, resetController.cod4.value),
                    inputCode(context, 4, resetController.cod5.value),
                    inputCode(context, 5, resetController.cod6.value),
                  ],
                ),
              ),
              //     StaggeredGridView.countBuilder(
              //  itemCount: 6,
              //  itemBuilder: (context, index) {

              //  },
            ),

            // Form(
            //   key: _formKey,
            //   child: StaggeredGridView.countBuilder(
            //     crossAxisCount: 6,
            //     itemCount: 6,
            //     crossAxisSpacing: 10,
            //     mainAxisSpacing: 10,
            //     itemBuilder: (context, index) {
            //       return inputCode(context,index);
            //     },
            //     staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            //   ),
            //   onChanged: () {
            //     if (_formKey.currentState.validate()) {
            //       print(_formKey.toString());
            //     }
            //   },
            // )
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              height: 20,
              padding: EdgeInsets.only(left: 20),
              child: Text(
                text('resend_code'),
                style: TextStyle(
                    fontFamily: "TTCommonsr", fontSize: 20, color: theamColor),
              ),
            ),
            Container(
              height: 30,
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Text(
                text('verification_code'),
                style: TextStyle(
                    fontFamily: "TTCommonsr", fontSize: 20, color: black),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Text(
                text('check_your_mail'),
                style: TextStyle(
                  fontFamily: "Poppinsr",
                  fontSize: 14,
                  color: Color(Helper.getHexToInt("#778191")),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            sendButton(),
          ])),
    );
  }

  Widget verificationimage() {
    return Container(
      width: 200,
      height: 280,
      padding: EdgeInsets.only(top: 20),
      // padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Image.asset(
        'assets/icons/verification.png',
        // fit: BoxFit.fill,
      ),
    );
  }

  Widget inputCode(
      BuildContext contextss, int index, TextEditingController cont) {
    // textFieldControllers[index] = new TextEditingController() ;
    final node = FocusScope.of(contextss);
    return Container(
        width: 45,
        height: 60,
        margin: EdgeInsets.only(left: 5, right: 5),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration:
            BoxDecoration(color: white, borderRadius: BorderRadius.circular(9)),
        child: Center(
            child: TextFormField(
          keyboardType: TextInputType.phone,
          // ignore: deprecated_member_use
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          // inputFormatters: [
          //   new LengthLimitingTextInputFormatter(1),
          // ],
          autofocus: true,
          controller: cont,
          // maxLength: 1,
          style: TextStyle(fontSize: 25.0, height: 1.5, color: Colors.black),
          textAlign: TextAlign.center,
          onChanged: (text) {
            print("text is" + text.toString());
            resetController.getotp(text);
            if (text.length > 0) {
              node.nextFocus();
            }
          },
          //
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '',
          ),
        )));
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
                // print(object)
                // print(textFieldControllers[1].text);

                resetController.checkverificationCode();
                // Get.to(NewPassword());
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
                  text('conform'),
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
        ],
      ),
    );
  }
}
