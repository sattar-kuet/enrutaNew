import 'package:empty_widget/empty_widget.dart';
import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/model/my_order_list_data.dart';
import 'package:enruta/screen/orerder/curentOrderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'curentOrderView.dart';

class AllOrder extends StatelessWidget {
//
  final detailsController = Get.put(CurentOrderController());

  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    List<MyorderListData> orderList = MyorderListData.curentOorderList;

    detailsController.getCurentOrder();
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
          title: Text(
              text('my_current_order'),
              style: TextStyle(
                  fontFamily: 'Poppinsm', fontSize: 18.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: Container(
            color: cardbackgroundColor,
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
                                left: 20, top: 25, right: 5, bottom: 10),
                            child: Text(
                              text('current_orders'),
                              style: TextStyle(
                                  fontFamily: "TTCommonsd",
                                  fontSize: 16,
                                  color: Color(Helper.getHexToInt("#000000"))
                                      .withOpacity(0.8)),
                            ),
                          ),
                         Obx(()=>
                             detailsController.allCurentOrderList.value.length>0?
                             ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: List.generate(1, (index){
                              return CurentOrderView(
                                orderModel: detailsController.allCurentOrderList.value[0],
                                    );
                            })


                            // List.generate(orderList.length, (index) {
                            //   return CurentOrderView(
                            //     orderData: orderList[index],
                            //   );
                            // }),
                          ):Container(
                               margin: EdgeInsets.all(50),
                               child: Center(
                                   child: EmptyListWidget(
                                       title: text('no_order'),
                                       subTitle: text('no_current_order_available_yet'),
                                       // image: 'assets/images/userIcon.png',
                                       image : null,
                                       packageImage: PackageImage.Image_2,
                                       titleTextStyle: Theme.of(context).typography.dense.display1.copyWith(color: Color(0xff9da9c7)),
                                       subtitleTextStyle: Theme.of(context).typography.dense.body2.copyWith(color: Color(0xffabb8d6))
                                   )
                               ),
                             )
                         )
                        ],
                      ),
                    ),
                  ])),
              // DraggableScrollableSheet(
              //     maxChildSize: 1,
              //     initialChildSize: .2,
              //     minChildSize: .2,
              //     builder: (context, scrollController) {
              //       return SingleChildScrollView(
              //           controller: scrollController,
              //           child: Container(
              //             // height: 400,
              //             // height: Get.height,
              //             padding: EdgeInsets.only(left: 20, right: 20),
              //             decoration: BoxDecoration(
              //                 color: white,
              //                 borderRadius: BorderRadius.only(
              //                     topLeft: Radius.circular(20),
              //                     topRight: Radius.circular(20))),
              //             child: Column(
              //               children: [
              //                 Container(
              //                   height: 20,
              //                   padding: EdgeInsets.all(10),
              //                   alignment: Alignment.centerRight,
              //                   child: Icon(
              //                     Icons.add_circle,
              //                     color: theamColor,
              //                   ),
              //                 ),
              //                 Container(
              //                   height: 120,
              //                   width: MediaQuery.of(context).size.width,
              //                   child: Image(
              //                     image: AssetImage(
              //                         "assets/icons/orderprocess.png"),
              //                   ),
              //                 ),
              //                 Center(
              //                   child: Text(
              //                     "Your Order Placed Successfully!",
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                         fontSize: 24,
              //                         fontFamily: 'TTCommonsd',
              //                         color:
              //                             Color(Helper.getHexToInt("#959595"))),
              //                   ),
              //                 ),
              //                 Text(
              //                   "It may take 40 min to arrive",
              //                   textAlign: TextAlign.center,
              //                   style: TextStyle(
              //                       fontSize: 18,
              //                       fontFamily: 'TTCommonsm',
              //                       color:
              //                           Color(Helper.getHexToInt("#959595"))),
              //                 ),
              //                 Container(
              //                   height: 50,
              //                   margin: EdgeInsets.only(
              //                       top: 20, left: 20, right: 20),
              //                   child: Flexible(
              //                     child: RichText(
              //                       textAlign: TextAlign.center,
              //                       maxLines: 4,
              //                       text: TextSpan(
              //                           style: TextStyle(
              //                               fontFamily: 'TTCommonsm',
              //                               fontSize: 15.0,
              //                               color: Color(Helper.getHexToInt(
              //                                       "#808080"))
              //                                   .withOpacity(0.8)),
              //                           text:
              //                               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry"
              //                               "s standard dummy text ever"),
              //                     ),
              //                   ),
              //                 ),
              //                 Divider(
              //                   thickness: 1,
              //                 ),
              //                 Container(
              //                   child: Align(
              //                     alignment: Alignment.centerLeft,
              //                     child: Text(
              //                       "Order Details",
              //                       style: TextStyle(
              //                           fontSize: 18,
              //                           fontFamily: 'TTCommonsm',
              //                           color: Color(
              //                               Helper.getHexToInt("#000000"))),
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Container(
              //                   height: 25,
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Row(
              //                     children: [
              //                       Align(
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                           "Your order from:",
              //                           textAlign: TextAlign.left,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#535353"))),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: Text(
              //                           "Veestro Healthy",
              //                           textAlign: TextAlign.right,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#000000"))),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Container(
              //                   height: 25,
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Row(
              //                     children: [
              //                       Align(
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                           "Your order number:",
              //                           textAlign: TextAlign.left,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#535353"))),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: Text(
              //                           "#u7vj-xsyf",
              //                           textAlign: TextAlign.right,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#000000"))),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Container(
              //                   height: 25,
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Row(
              //                     children: [
              //                       Align(
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                           "Delivery address:",
              //                           textAlign: TextAlign.left,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#535353"))),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: Text(
              //                           "Gulshan Avinew, Dhaka",
              //                           maxLines: 1,
              //                           textAlign: TextAlign.right,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#000000"))),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Divider(
              //                   thickness: 1,
              //                 ),
              //                 Container(
              //                   height: 25,
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Row(
              //                     children: [
              //                       Container(
              //                         height: 20,
              //                         width: Get.width / 2,
              //                         alignment: Alignment.centerLeft,
              //                         child: RichText(
              //                           textAlign: TextAlign.center,
              //                           maxLines: 2,
              //                           text: TextSpan(
              //                               style: TextStyle(
              //                                   fontFamily: 'TTCommonsm',
              //                                   fontSize: 18.0,
              //                                   color: Color(Helper.getHexToInt(
              //                                       "#535353"))),
              //                               text:
              //                                   "Beef Rejala, Plain Rice, Hisha Fish, Pabda Fish and Dal"),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: Text(
              //                           "\$" + "85",
              //                           maxLines: 1,
              //                           textAlign: TextAlign.right,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#000000"))),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Divider(
              //                   thickness: 1,
              //                 ),
              //                 Container(
              //                   height: 25,
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Row(
              //                     children: [
              //                       Container(
              //                         height: 20,
              //                         width: Get.width / 2,
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                           "Subtotal:",
              //                           textAlign: TextAlign.left,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#535353"))),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: Text(
              //                           "\$" + "85",
              //                           maxLines: 1,
              //                           textAlign: TextAlign.right,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#000000"))),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Container(
              //                   height: 25,
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Row(
              //                     children: [
              //                       Container(
              //                         height: 20,
              //                         width: Get.width / 2,
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                           "Delivery fee:",
              //                           textAlign: TextAlign.left,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#535353"))),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: Text(
              //                           "\$" + "5",
              //                           maxLines: 1,
              //                           textAlign: TextAlign.right,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#000000"))),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Container(
              //                   height: 25,
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Row(
              //                     children: [
              //                       Container(
              //                         height: 20,
              //                         width: Get.width / 2,
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                           "Voucher:",
              //                           textAlign: TextAlign.left,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#535353"))),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: Text(
              //                           "\$" + "-20",
              //                           maxLines: 1,
              //                           textAlign: TextAlign.right,
              //                           style: TextStyle(
              //                               fontSize: 18,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#000000"))),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Divider(
              //                   thickness: 1,
              //                 ),
              //                 Container(
              //                   height: 35,
              //                   padding: EdgeInsets.only(top: 10),
              //                   child: Row(
              //                     children: [
              //                       Container(
              //                         height: 20,
              //                         width: Get.width / 2,
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                           "Total (incl. VAT):",
              //                           textAlign: TextAlign.left,
              //                           style: TextStyle(
              //                               fontSize: 22,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#535353"))),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: Text(
              //                           "\$" + "70",
              //                           maxLines: 1,
              //                           textAlign: TextAlign.right,
              //                           style: TextStyle(
              //                               fontSize: 22,
              //                               fontFamily: 'TTCommonsm',
              //                               color: Color(
              //                                   Helper.getHexToInt("#000000"))),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //               ],
              //             ),
              //           ));
              //     }),
            ])));
  }
}
