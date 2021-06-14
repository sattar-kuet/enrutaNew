import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/screen/orerder/curentOrderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderStatus extends StatelessWidget {
  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    final detailsController = Get.put(CurentOrderController());

    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: ListView(
        children: [
          // Container(
          //   height: 20,
          //   padding: EdgeInsets.all(10),
          //   alignment: Alignment.centerRight,
          //   child: Icon(
          //     Icons.add_circle,
          //     color: theamColor,
          //   ),
          // ),
          Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/icons/orderprocess.png")),
          Padding(padding: EdgeInsets.only(top: 10)),
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
            text('it_may_take_40_min_to_arrive'),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'TTCommonsm',
                color: Color(Helper.getHexToInt("#959595"))),
          ),
          // Container(
          //   height: 50,
          //   margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          //   child: Flexible(
          //     child: RichText(
          //       textAlign: TextAlign.center,
          //       maxLines: 4,
          //       text: TextSpan(
          //           style: TextStyle(
          //               fontFamily: 'TTCommonsm',
          //               fontSize: 15.0,
          //               color: Color(Helper.getHexToInt("#808080"))
          //                   .withOpacity(0.8)),
          //           text:
          //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry"
          //               "s standard dummy text ever"),
          //     ),
          //   ),
          // ),
          // Container(
          //   child: RichText(
          //     text: TextSpan(
          //       style: TextStyle(
          //           fontFamily: 'TTCommonsm',
          //           fontSize: 15.0,
          //           color:
          //               Color(Helper.getHexToInt("#808080")).withOpacity(0.8)),
          //       children: <TextSpan>[
          //         TextSpan(
          //             text:
          //                 "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry"
          //                 "s standard dummy text ever"),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(padding: EdgeInsets.only(top: 50)),
          Divider(
            thickness: 1,
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text('order_details'),
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
                  child: Text(
                    text('your_order_form'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'TTCommonsm',
                        color: Color(Helper.getHexToInt("#535353"))),
                  ),
                ),
                Expanded(
                  child: Text(
                    detailsController.detailsModel.value.order.orderFrom,
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
                    detailsController.detailsModel.value.order.number,
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
                    detailsController.address.value,
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
                        text: detailsController
                            .detailsModel.value.order.orderItemNames),
                  ),
                ),
                Expanded(
                  child: Text(
                    "\$" + detailsController.detailsModel.value.order.price,
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
                    "\$" + detailsController.detailsModel.value.order.price,
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
                    "\$" +
                        detailsController
                            .detailsModel.value.order.deliveryCharge
                            .toString(),
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
                    "\$" +
                        "-" +
                        detailsController.detailsModel.value.order.voucher
                            .toString(),
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
                    "\$" + detailsController.detailsModel.value.order.price,
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
    ));
  }
}
