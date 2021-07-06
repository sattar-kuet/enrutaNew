import 'package:carousel_slider/carousel_slider.dart';
import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/controllers/paymentController.dart';
import 'package:enruta/controllers/productController.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

// ignore: must_be_immutable
class AddNewMethod extends StatelessWidget {
  List imgList = [0, 1, 2];
  final pController = Get.put(ProductController());
  final payController = Get.put(PaymentController());

  final cardHName = TextEditingController();
  final cardNumber = TextEditingController();
  final expaireDate = TextEditingController();
  final cvvCode = TextEditingController();

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
              Navigator.of(context).pop();
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
          title: Text(text('add_new_card'),
              style: TextStyle(
                  fontFamily: 'Poppinsm', fontSize: 18.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            card(),
            Container(
              // margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              alignment: Alignment.centerLeft,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text('card_holder_name'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(Helper.getHexToInt("#22242A"))
                          .withOpacity(0.44),
                      fontFamily: 'TTCommonsm',
                    ),
                  ),
                  Container(
                    height: 15,
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Jahid Jaykar",
                        hintStyle: TextStyle(
                          color: Color(Helper.getHexToInt("#22242A"))
                              .withOpacity(.1),
                          fontSize: 16.0,
                        ),
                        border: InputBorder.none,
                      ),
                      // focusNode: payController.myFocusNode,
                      controller: cardHName,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: divider,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 26),
              // margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text('card_number'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(Helper.getHexToInt("#22242A"))
                          .withOpacity(0.44),
                      fontFamily: 'TTCommonsm',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          // height: 40,
                          // width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            inputFormatters: [
                              CreditCardNumberInputFormatter(),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "5560  1209  0987  4312",

                              hintStyle: TextStyle(
                                color: Color(Helper.getHexToInt("#22242A"))
                                    .withOpacity(.1),
                                fontSize: 16.0,
                              ),
                              border: InputBorder.none,
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(20.0),
                              // ),
                            ),
                            controller: cardNumber,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 15,
                        alignment: Alignment.centerRight,
                        // decoration: BoxDecoration(
                        // image: DecorationImage(
                        child: Image.network(
                            'https://img.pngio.com/visa-card-logo-2020-visa-logo-png-5000_1533.png',
                            fit: BoxFit.fill),
                        //  ),
                        // ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: divider,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 15),
              // margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          text('expire_date'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(Helper.getHexToInt("#22242A"))
                                .withOpacity(0.44),
                            fontFamily: 'TTCommonsm',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "CVV",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(Helper.getHexToInt("#22242A"))
                                .withOpacity(0.44),
                            fontFamily: 'TTCommonsm',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CreditCardExpirationDateFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintText: "06/24",
                            hintStyle: TextStyle(
                              color: Color(Helper.getHexToInt("#22242A"))
                                  .withOpacity(.1),
                              fontSize: 16.0,
                            ),
                            border: InputBorder.none,
                          ),
                          controller: expaireDate,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CreditCardCvcInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintText: "556 ",
                            hintStyle: TextStyle(
                              color: Color(Helper.getHexToInt("#22242A"))
                                  .withOpacity(.1),
                              fontSize: 16.0,
                            ),
                            border: InputBorder.none,
                          ),
                          controller: cvvCode,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: divider,
                  )
                ],
              ),
            ),
            orderbottomfield(),
          ],
        ));
  }

  Widget card() {
    var heightImage = Get.height / 3.0;
    return Container(
      height: heightImage,
      child: Column(
        children: [
          Container(
            height: 200,
            child: CarouselSlider(
                items: imgList.map((i) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      width: Get.width,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              // image: NetworkImage(
                              //     'https://www.amexcommercial.com/wp-content/uploads/2020/09/Halley-Chase-bank....png'),
                              image: AssetImage('assets/images/mycard.png'),
                              scale: 1.0,
                              fit: BoxFit.fill),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: theamColor,
                                blurRadius: 10.0,
                                offset: Offset(0, 5))
                          ]),
                      // child: Image.network(
                      //     'https://www.amexcommercial.com/wp-content/uploads/2020/09/Halley-Chase-bank....png',
                      //     fit: BoxFit.fill),
                    );
                  });
                }).toList(),
                options: CarouselOptions(
                  height: 170,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    pController.changeIndex(index);
                    print(pController.position.value);
                  },
                )),
          ),
          // Container(
          //   padding: EdgeInsets.only(right: 20, top: 10),
          //   child: Obx(
          //     () => Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: <Widget>[
          //         for (int i = 0; i < imgList.length; i++)
          //           if (i == pController.position.value)
          //             circleBar(true)
          //           else
          //             circleBar(false),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isActive ? 16 : 12,
      width: isActive ? 16 : 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: isActive ? Color(Helper.getHexToInt("#11C4A1")) : null,
        // border: isActive
        //     ? Border.all(color: Color(Helper.getHexToInt("#11C4A1")))
        //     : null,
      ),
      padding: EdgeInsets.all(isActive ? 4.0 : 0.0),
      child: Container(
        width: isActive ? 16 : 16,
        height: isActive ? 16 : 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color(Helper.getHexToInt("#11C4A1")).withOpacity(0.22),
        ),
      ),
    );
  }

  Widget orderbottomfield() {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            // Navigator.pop(context);
            Get.back();
            // showSuccessfullyBottompopup(context);
          },
          child: Container(
            height: 57,
            margin: EdgeInsets.all(10),
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
              text('ADD_CARD'),
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'TTCommonsm',
              ),
            )),
          ),
        ),
      ],
    );
  }
}
