import 'package:enruta/controllers/cartController.dart';
import 'package:enruta/controllers/suggestController.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/model/Product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartSlidView extends StatelessWidget {
  const CartSlidView(
      {Key key,
      this.cartData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  // final CartListData cartData;
  final Product cartData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width / 1.3,

      margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
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
              bottom: 5,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // image: DecorationImage(
                  //     image: AssetImage(cartData.logo), fit: BoxFit.cover),
                ),
                child: Image.network(cartData.logo, fit: BoxFit.fill,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                  return Center(child: Text('😢'));
                }),
              ),
            ),
            Positioned(
              top: 10,
              left: 100,
              child: Container(
                child: Text(
                  cartData.title,
                  style: TextStyle(
                      fontFamily: "TTCommonsd",
                      fontSize: 16,
                      color: Color(Helper.getHexToInt("#000000"))),
                ),
              ),
            ),
            Positioned(
              top: 35,
              left: 100,
              right: 10,
              child: Container(
                child: Text(
                  cartData.subTxt,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'TTCommonsm',
                    color: Color(Helper.getHexToInt("#6E6E6E")),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 100,
              height: 25,
              width: 35,
              child: Container(
                alignment: Alignment.center,
                width: 35,
                height: 27,
                decoration: BoxDecoration(
                    color: Color(Helper.getHexToInt("#FFF7E4")),
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  "\$" + cartData.price.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(Helper.getHexToInt("#FFBB19")),
                    fontFamily: 'TTCommonsd',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 10,
              height: 25,
              width: 25,
              child: InkWell(
                onTap: () {
                  cartData.qty = 1;
                  print(cartData.price);
                  // // var shopids = suggestcont.shopid.value;
                  // // var vat = suggestcont.vats.value;
                  // // var deliveryCharge = suggestcont.dc.value;
                  // print("shopid secd " '$shopids');
                  // cartData.addtolist();
                  // cartController.totalcalculate();
                  // cartController.additemtocarts(
                  //     cartData, shopids, vat, deliveryCharge);
                  Get.find<SuggestController>().addtolist(cartData);
                  Get.find<CartController>().totalcalculate();
                  // Get.find<SuggestController>().removeitemfromlist(cartData.id);
                  // suggestcont.addtolist(cartData);
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: Color(Helper.getHexToInt("#3AD8B4")),
                        borderRadius: BorderRadius.circular(3)),
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
