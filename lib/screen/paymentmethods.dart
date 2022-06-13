import 'package:enruta/controllers/cartController.dart';
import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/controllers/paymentController.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/model/payment_method_list_data.dart';
import 'package:enruta/screen/addNewMethod.dart';

import 'package:enruta/view/payment_method_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Paymentmethods extends StatefulWidget {
  @override
  _PaymentmethodsState createState() => _PaymentmethodsState();
}

class _PaymentmethodsState extends State<Paymentmethods> {
  List<PaymentMethodListData> paymentMethodList =
      PaymentMethodListData.paymentMethodList;

  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    final pmController = Get.put(PaymentController());
    // var colorType = pmController.selectedMethod.value;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            child: Stack(children: [
          Container(
              margin: EdgeInsets.only(top: 5),
              child: Column(children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            top: 30,
                            right: 5,
                          ),
                          child:
                              //  Obx(() =>
                              // pmController.totalPayment.value != 0
                              //     ?
                              Text(
                            text('please_choose_your'),
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Color(Helper.getHexToInt("#8D8D8D"))
                                    .withOpacity(1)),
                          )
                          // : SizedBox(
                          //     height: 0,
                          //   ),
                          // )
                          ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 5, bottom: 10),
                        child: Text(
                          text('payment_method'),
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              color: Color(Helper.getHexToInt("#000000"))
                                  .withOpacity(0.8)),
                        ),
                      ),
                      Obx(() => Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: pmController.selectedMethod.value == 1
                                    ? cardbackgroundColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 2,
                                    color: pmController.selectedMethod.value ==
                                            1
                                        ? Color(Helper.getHexToInt("#11C4A1"))
                                        : Color(
                                            Helper.getHexToInt("#F0F0F0")))),
                            child: InkWell(
                              onTap: () {
                                pmController.selectedMethod.value =1;

                                Get.find<CartController>()
                                    .setpayment("Cash on delivery");

                                pmController.paymentType.value =1;
                                if (pmController.totalPayment.value != 0)
                                  Get.back();
                                print("Add New Card");
                                // pmController.selectedMethod(1);
                                // colorType = pmController.selectedMethod.value;
                                // Get.back();
                              },
                              child: Align(
                                alignment: Alignment.center,
                                // child: InkWell(
                                // onTap: () {

                                // },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(right: 10),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          text('cash_on_delivery'),
                                          style: TextStyle(
                                              fontFamily: "TTCommonsd",
                                              fontSize: 16,
                                              color: Color(Helper.getHexToInt(
                                                  "#11C4A1"))),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            child: Image.asset(
                                                'assets/icons/cashpa.png')),
                                      ),
                                    ),
                                  ],
                                  // ),
                                ),
                              ),
                            ),
                            // ),
                          )),
                      ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children:
                            List.generate(paymentMethodList.length, (index) {
                          return PaymentMethodListView(
                            paymentData: paymentMethodList[index],
                          );
                        }),
                      ),
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            top: 5, bottom: 5, left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 2,
                                color: Color(Helper.getHexToInt("#F0F0F0")))),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Get.to(AddNewMethod());
                              print("Add New Method");
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(right: 10),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      text('add_new_card'),
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        child: Icon(
                                      Icons.add,
                                      color:
                                          Color(Helper.getHexToInt("#11C4A1")),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => pmController.totalPayment.value != 0
                            ? Container(
                                height: 25,
                                margin: EdgeInsets.only(top: 40),
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      text('total_amount'),
                                      style: TextStyle(
                                          fontFamily: "TTCommonsm",
                                          fontSize: 15,
                                          color: Color(
                                              Helper.getHexToInt("#5E6B6A"))),
                                    ),
                                    Text(
                                      "\$" +
                                          '${pmController.totalPayment.value}',
                                      style: TextStyle(
                                          fontFamily: "TTCommonsm",
                                          fontSize: 15,
                                          color: Color(
                                              Helper.getHexToInt("#5E6B6A"))),
                                    ),
                                  ],
                                ))
                            : SizedBox(
                                height: 0,
                              ),
                      ),
                      Obx(
                        () => pmController.totalPayment.value != 0
                            ? Container(
                                height: 25,
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                margin: EdgeInsets.only(bottom: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      text('payment'),
                                      style: TextStyle(
                                          fontFamily: "TTCommonsm",
                                          fontSize: 15,
                                          color: Color(
                                              Helper.getHexToInt("#5E6B6A"))),
                                    ),
                                    Text(
                                      text('cash_on_delivery'),
                                      style: TextStyle(
                                          fontFamily: "TTCommonsm",
                                          fontSize: 15,
                                          color: Color(
                                              Helper.getHexToInt("#5E6B6A"))),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: 0,
                              ),
                      ),
                    ],
                  ),
                ),
                Obx(() => pmController.totalPayment.value != 0
                    ? buidbottomfield(context)
                    : SizedBox(
                        height: 0,
                      ))
              ])),
        ])));
  }

  Widget buidbottomfield(BuildContext context) {
    return Dismissible(
      background: Container(
        color: theamColor,
      ),
      onDismissed: (direction) {
        // Get.off(CartPage());
        Get.back();
      },
      key: ValueKey("done"),
      child: Stack(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.only(right: 100),
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                Color(Helper.getHexToInt("#11C7A1")),
                Color(Helper.getHexToInt("#11E4A1"))
              ]),
            ),
            child: Center(
                child: Text(
              text('SWIPE_FOR_ORDER'),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'TTCommonsm',
              ),
            )),
          ),
          Positioned(
            right: 20,
            top: 10,
            child: InkWell(
              child: Center(
                child: Container(
                  alignment: Alignment.topLeft,
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(Helper.getHexToInt("#41E9C3")),
                      borderRadius: BorderRadius.circular(9)),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
