import 'package:enruta/controllers/cartController.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/model/Product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListView extends StatelessWidget {
  const CartListView(
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
    // var qt = cartData.qty.obs;
    // final CartController cartCont = Get.put(CartController());
    final CartController cartController = Get.find();
    // cartData.pqty.value = cartData.qty;
    var qt = cartData.qty.obs;
    var subtotal = 0.0.obs;
    cartData.qty = qt.value;
    if (cartData.qty != null && cartData.price != null) {
      subtotal.value = (cartData.qty * cartData.price);
    }

    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Color(
            Helper.getHexToInt("#FFFFFF"),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            // _launchInWebViewOrVC("https://corona.gov.bd/");
          },
          child: Stack(
            children: [
              // Text("dkfjsldkfj"),
              Positioned(
                top: 10,
                left: 10,
                bottom: 10,
                child: Container(
                  height: 75,
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // image: DecorationImage(
                    //     image: NetworkImage(cartData.logo), fit: BoxFit.cover),
                  ),
                  child: cartData.logo == null
                      ? Image.asset("assets/icons/image.png", fit: BoxFit.fill)
                      : Image.network(cartData.logo, fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                          return Center(
                              child: Image.asset(
                            "assets/icons/image.png",
                            scale: 5,
                          ));
                        }),
                ),
              ),
              Positioned(
                top: 15,
                left: 115,
                child: Container(
                  child: Text(
                    cartData.title,
                    style: TextStyle(
                        fontFamily: 'TTCommonsd',
                        fontSize: 16,
                        color: Color(Helper.getHexToInt("#959595"))),
                  ),
                ),
              ),
              Positioned(
                top: 45,
                left: 115,
                child: Container(
                  child: Obx(() => subtotal != null
                      ? Text(
                          "\$" + subtotal.toString(),
                          style: TextStyle(
                              fontFamily: 'TTCommonsm',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(Helper.getHexToInt("#959595"))),
                        )
                      : null),
                ),
              ),
              Positioned(
                  right: 15,
                  top: 5,
                  bottom: 5,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        child: InkWell(
                          onTap: () {
                            print("add");
                            cartData.qty++;
                            qt++;
                            cartController.addtocarts(cartData);
                            subtotal.value = (cartData.qty * cartData.price);
                            cartController.totalcalculate();
                            // GetStorage box = GetStorage();
                            // box.write("cartList",
                            //     Get.find<CartController>().cartList);
                          },
                          child: Center(
                              child: Icon(
                            Icons.add,
                            size: 25,
                            color: Color(Helper.getHexToInt("#6E6E6E")),
                          )),
                        ),
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      // Expanded(
                      //   child:

                      Obx(
                        () => Container(
                          width: 21,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Color(Helper.getHexToInt("#3AD8B4")),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text(
                            qt.toString(),
                            // cartController.countqty.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'TTCommonsm', color: Colors.white),
                          )),
                        ),
                      ),

                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (cartData.qty > 1) {
                              cartData.qty--;
                              qt--;
                              subtotal.value = (cartData.qty * cartData.price);
                              cartController.addtocarts(cartData);
                              cartController.totalcalculate();
                              // GetStorage box = GetStorage();
                              // box.write("cartList",
                              //     Get.find<CartController>().cartList);
                            }

                            // print("remove");
                          },
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: 25,
                              color: Color(Helper.getHexToInt("#6E6E6E")),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
