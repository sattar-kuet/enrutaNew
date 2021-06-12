import 'package:enruta/helper/helper.dart';
import 'package:enruta/model/all_order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderListView extends StatelessWidget {
  const MyOrderListView(
      {Key key,
      this.orderData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final OrderModel orderData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      margin: EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // _launchInWebViewOrVC("https://corona.gov.bd/");
        },
        child: Stack(
          children: [
            Positioned(
              top: 5,
              left: 5,
              bottom: 10,
              child: Container(
                height: 92,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // image: DecorationImage(
                  //     image: Image.network(orderData.imagePath, fit: BoxFit.cover)
                  //    ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    orderData.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Center(
                          child: Image.asset(
                        "assets/icons/image.png",
                        scale: 5,
                      ));
                    },
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.only(top: 10, left: 10),
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 24,
                decoration: BoxDecoration(
                    color: Color(Helper.getHexToInt("#FFF7E4")),
                    // color: Colors.green,
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  "\$" + "573",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(Helper.getHexToInt("#FFBB19")),
                    fontFamily: 'TTCommonsd',
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 113,
              right: 50,
              child: Container(
                width: Get.width / 2,
                child: Text(
                  orderData.shopName,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontFamily: "TTCommonsd",
                      fontSize: 16,
                      color: Color(Helper.getHexToInt("#000000"))),
                ),
              ),
            ),
            Positioned(
              top: 35,
              left: 113,
              right: 90,
              child: Container(
                child: Text(
                  orderData.titleTxt,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontFamily: 'TTCommonsm',
                    color:
                        Color(Helper.getHexToInt("#6E6E6E")).withOpacity(0.5),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 67,
              left: 113,
              right: 120,
              child: Text(
                orderData.date,
                textAlign: TextAlign.justify,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'TTCommonsr',
                  color: Color(Helper.getHexToInt("#B6B6B6")).withOpacity(1),
                  fontSize: 12,
                ),
              ),
            ),
            // Positioned(
            //     top: 67,
            //     left: 185,
            //     child: Container(
            //       width: 11,

            //       height: double.maxFinite,
            //       color: Colors.black,
            //     )),
            // Positioned(
            //   top: 67,
            //   left: 196,
            //   child: Text(
            //     orderData.time,
            //     textAlign: TextAlign.justify,
            //     maxLines: 2,
            //     style: TextStyle(
            //       fontFamily: 'TTCommonsm',
            //       color: Color(Helper.getHexToInt("#6E6E6E")).withOpacity(0.5),
            //       fontSize: 10,
            //     ),
            //   ),
            // ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                child: Container(
                  height: 25,
                  width: 55,
                  decoration: BoxDecoration(
                      color: Color(Helper.getHexToInt("#3AD8B4")),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Reorder",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'TTCommonsm',
                          fontSize: 12),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // ),
    );
  }
}
