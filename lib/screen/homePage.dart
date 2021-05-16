import 'package:carousel_pro/carousel_pro.dart';
import 'package:enruta/controllers/cartController.dart';
import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/controllers/textController.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/model/item_list_data.dart';
import 'package:enruta/screen/bottomnavigation/bottomNavigation.dart';
import 'package:enruta/screen/orerder/curentOrderController.dart';
import 'package:enruta/screen/resetpassword/resetController.dart';
import 'package:enruta/screen/setLocation.dart';

import 'package:enruta/view/menu_list_view.dart';
import 'package:enruta/view/popular_shop_list_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/helper.dart';
import 'drawer/myDrawerPage.dart';
import 'promotion/promotion.dart';
import 'package:empty_widget/empty_widget.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final tController = Get.put(TestController());
  final cartController = Get.put(CartController());
  final dController = Get.put(ResetController());
  final popularController = Get.put(CurentOrderController());

  // LatLng(tController.userlat.value, tController.userlong.value)

  List<ItemListData> itemList = ItemListData.itemList;

  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    tController.getmenulist();
    language.loadLanguage();
    return Scaffold(
      drawer: MyDrawerPage(),
      body: Container(
        child: Stack(
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 50),
              padding: EdgeInsets.only(bottom: 30),

              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height / 8,
                    height: 110,
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
                            top: 30,
                            left: 100,
                            right: 100,
                            child: Center(
                              child: Text(text('home'),
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18.0,
                                      color: Colors.white)),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            left: 50,
                            // right: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                          ),
                          Positioned(
                            top: 62,
                            left: 15,
                            right: 15,
                            child: InkWell(
                              onTap: () {
                                Get.to(SetLocation());
                              },
                              child: Align(
                                // alignment: Alignment.topCenter,
                                child: Container(
                                  // width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 19,
                                        color: Colors.white,
                                      ),
                                      Container(child: Obx(() {
                                        return Flexible(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontFamily: 'TTCommonsm',
                                                    fontSize: 13.0,
                                                    color: Color(
                                                            Helper.getHexToInt(
                                                                "#FFFFFF"))
                                                        .withOpacity(0.8)),
                                                text:
                                                    '${tController.address.value}'),
                                          ),
                                        );
                                      })),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: white.withOpacity(0.8),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Color(Helper.getHexToInt("#F8F9FF")),
                    width: 120,
                    child: Obx(
                      () => GridView.count(
                        crossAxisCount: 4,

                        controller: new ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(15),
                        children:
                            List.generate(tController.category.length, (index) {
                          return MenuItemView(
                            categoryData: tController.category[index],
                          );
                        }),
                      ),
                    ),
                  ),
                  // Obx(
                  //   () => cartController.newOrder.value > 0
                  //       ? Container(
                  //           height: 120,
                  //           width: MediaQuery.of(context).size.width,
                  //           margin: EdgeInsets.only(
                  //               top: 5, bottom: 5, left: 20, right: 20),

                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(8),
                  //           ),
                  //           // child: Center(
                  //           child: InkWell(
                  //             onTap: () {
                  //               // Get.to(AddNewMethod());
                  //               showSuccessfullyBottompopup(context);
                  //               // shoall(context);
                  //               print("Add New Method");
                  //             },
                  //             child: Column(
                  //               children: [
                  //                 Container(
                  //                   height: 20,
                  //                   margin: EdgeInsets.only(top: 20),
                  //                   padding:
                  //                       EdgeInsets.only(left: 20, right: 20),
                  //                   child: Row(
                  //                     children: [
                  //                       Image.asset(
                  //                           "assets/icons/roundpoint.png"),
                  //                       // Icon(Icons.radio_button_on_rounded),
                  //                       Container(
                  //                         padding: EdgeInsets.only(left: 10),
                  //                         child: Text(
                  //                           "Home Kitchen & Restaurant",
                  //                           style: TextStyle(
                  //                               fontFamily: 'TTCommonsm',
                  //                               fontSize: 15,
                  //                               color: Color(Helper.getHexToInt(
                  //                                       "#11C4A1"))
                  //                                   .withOpacity(0.8)),
                  //                           textAlign: TextAlign.start,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 Container(
                  //                   margin: EdgeInsets.only(
                  //                       top: 20, left: 20, right: 50),
                  //                   child: Flexible(
                  //                     // child: Text("data"),
                  //                     child: RichText(
                  //                       textAlign: TextAlign.center,
                  //                       maxLines: 2,
                  //                       text: TextSpan(
                  //                           style: TextStyle(
                  //                               fontFamily: 'TTCommonsm',
                  //                               fontSize: 13.0,
                  //                               color: Color(Helper.getHexToInt(
                  //                                       "#808080"))
                  //                                   .withOpacity(0.8)),
                  //                           text:
                  //                               'Restaurant preparing your food. Your rider will pic it once  ready'),
                  //                     ),
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //       : SizedBox(
                  //           height: 0,
                  //         ),
                  // ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: 5, bottom: 20, left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10, bottom: 10, top: 10),
                                  child: Text( text('what_s_new'),
                                    style: TextStyle(
                                        fontFamily: 'TTCommonsm',
                                        fontSize: 17,
                                        color:
                                            Color(Helper.getHexToInt("#000000"))
                                                .withOpacity(0.8)),
                                    textAlign: TextAlign.start,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: showSlider(),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => tController.polularShopList.value.length > 0
 /**/                     ? Container(
                          padding: EdgeInsets.only(bottom: 50),
                          color: cardbackgroundColor,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 20, bottom: 10, top: 20),
                                        child: Text(text('popular_restaurants'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'TTCommonsm',
                                              fontSize: 17,
                                              color: Color(Helper.getHexToInt(
                                                      "#000000"))
                                                  .withOpacity(0.8)),
                                        )),
                                  ),
                                  // Expanded(
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: 20, bottom: 10, top: 20),
                                      child: Text(text('view_all'),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontFamily: 'TTCommonsm',
                                            fontSize: 17,
                                            color: Color(Helper.getHexToInt(
                                                    "#11C4A1"))
                                                .withOpacity(1)),
                                      )),
                                  // )
                                ],
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width - 10,
                                  child: Obx(
                                    () =>
                                    tController.polularShopList.value.length
                                  > 0
                                        ? GridView.count(
                                            crossAxisCount: 2,
                                            controller: new ScrollController(keepScrollOffset: false),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            childAspectRatio: 0.9,
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                right: 10,
                                                left: 10),
                                            children: List.generate(
                                                tController
                                                    .polularShopList
                                                    .value
                                                    .length, (index) {
                                              return PopularShopListView(
                                                itemData: tController
                                                    .polularShopList
                                                    .value[index],
                                              );
                                            }),
                                          )
                                        : Text(""),
                                  )),
                            ],
                          ),
/**/                        )
                      : Container(
                          margin: EdgeInsets.all(40),
                          child: Center(
                              child: EmptyListWidget(
                                  title: text('no_restaurants'),
                                  subTitle:text('no_popular_restaurants_available_yet'),
                                  // image: 'assets/images/userIcon.png',
                                  image: null,
                                  packageImage: PackageImage.Image_1,
                                  titleTextStyle: Theme.of(context)
                                      .typography
                                      .dense
                                      .display1
                                      .copyWith(color: Color(0xff9da9c7)),
                                  subtitleTextStyle: Theme.of(context)
                                      .typography
                                      .dense
                                      .body2
                                      .copyWith(color: Color(0xffabb8d6)))),
                        ))
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
          ],
        ),
      ),
    );
  }

  Widget showSlider() {
    return Container(
      height: 148.0,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: () {
          Get.to(Promotion());
        },
        child: Carousel(
          dotPosition: DotPosition.bottomLeft,
          overlayShadow: false,
          borderRadius: true,
          boxFit: BoxFit.fill,
          autoplay: true,
          images: [
            AssetImage('assets/icons/3899145.png'),
            AssetImage('assets/icons/3515737.png'),
            AssetImage('assets/icons/3899145.png'),
          ],
          dotSize: 5.0,
          indicatorBgPadding: 1.0,
        ),
      ),
    );
  }

  Widget showSuccessfullyBottompopup(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext bc) {
          // return shoall(context);
          return Container(
            // height: 400,
            // height: Get.height,
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView(
              children: [
                Container(
                  height: 20,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.add_circle,
                    color: theamColor,
                  ),
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: AssetImage("assets/icons/orderprocess.png"),
                  ),
                ),
                Center(
                  child: Text( text('your_order_placed_successfully'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'TTCommonsd',
                        color: Color(Helper.getHexToInt("#959595"))),
                  ),
                ),
                Text(text('it_may_take_40_min_to_arrive'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'TTCommonsm',
                      color: Color(Helper.getHexToInt("#959595"))),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Flexible(
                    child: RichText(
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      text: TextSpan(
                          style: TextStyle(
                              fontFamily: 'TTCommonsm',
                              fontSize: 15.0,
                              color: Color(Helper.getHexToInt("#808080"))
                                  .withOpacity(0.8)),
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry"
                              "s standard dummy text ever"),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(text('order_details'),
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'TTCommonsm',
                          color: Color(Helper.getHexToInt("#000000"))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 25,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(text('your_order_form'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#535353"))),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          text('veestro_healthy'),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#000000"))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 25,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('your_order_number'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#535353"))),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "#u7vj-xsyf",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#000000"))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 25,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('delivery_address'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#535353"))),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Gulshan Avinew, Dhaka",
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#000000"))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  height: 25,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: Get.width / 2,
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'TTCommonsm',
                                  fontSize: 18.0,
                                  color: Color(Helper.getHexToInt("#535353"))),
                              text:
                                  "Beef Rejala, Plain Rice, Hisha Fish, Pabda Fish and Dal"),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$" + "85",
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#000000"))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  height: 25,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: Get.width / 2,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('subtotal'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#535353"))),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$" + "85",
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#000000"))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 25,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: Get.width / 2,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('delivery_fee'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#535353"))),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$" + "5",
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#000000"))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 25,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: Get.width / 2,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('voucher'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#535353"))),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$" + "-20",
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#000000"))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  height: 35,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: Get.width / 2,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('total_include_vat'),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#535353"))),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$" + "70",
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'TTCommonsm',
                              color: Color(Helper.getHexToInt("#000000"))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  Widget shoall(BuildContext context) {
    return DraggableScrollableSheet(
        maxChildSize: .95,
        initialChildSize: .2,
        minChildSize: .2,
        builder: (context, scrollController) {
          return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: white,
                ),
                child: Column(
                  children: [
                    Text("data"),
                    Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        image: AssetImage("assets/icons/orderprocess.png"),
                      ),
                    ),
                    Center(
                      child: Text(
                        text('your_order_placed_successfully'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'TTCommonsd',
                            color: Color(Helper.getHexToInt("#959595"))),
                      ),
                    ),
                    Text(
                      text('you_will_receive_confirmation_on_your_email'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'TTCommonsm',
                          color: Color(Helper.getHexToInt("#959595"))),
                    ),
                  ],
                ),
              ));
        });
  }
}
