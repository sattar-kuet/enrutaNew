import 'package:enruta/controllers/cartController.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/model/Product_model.dart';
import 'package:enruta/screen/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewListView extends StatelessWidget {
  const ReviewListView(
      {Key key,
      this.menuitemdata,
      this.animationController,
      this.animation,
      this.callback,
      this.shopid,
      this.vat,
      this.deliveryCharge})
      : super(key: key);

  final VoidCallback callback;
  final Product menuitemdata;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final String shopid;
  final int vat;
  final int deliveryCharge;

  @override
  Widget build(BuildContext context) {
    // final MenuController cartController = Get.put(MenuController());
    final CartController cartController = Get.put(CartController());
    print(cartController.cartItems.length);

    return Container(
      height: 105,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          if (menuitemdata.sizes.length != 0 ||
              menuitemdata.colors.length != 0) {
            print(shopid);
            Get.to(ProductDetails(
              menuitemdata: menuitemdata,
              shopid: shopid,
              vat: vat,
              deliveryCharge: deliveryCharge,
            ));
          }

          // Get.to(HomePage());
          // _launchInWebViewOrVC("https://corona.gov.bd/");
        },
        child: Stack(
          children: [
            Positioned(
              top: 5,
              left: 5,
              bottom: 10,
              child: InkWell(
                onTap: () {
                  //print("Size length ${menuitemdata.sizes.length}");
                  if (menuitemdata.sizes.length != 0 ||
                      menuitemdata.colors.length != 0) {
                    Get.to(ProductDetails(
                      menuitemdata: menuitemdata,
                      shopid: shopid,
                      vat: vat,
                      deliveryCharge: deliveryCharge,
                    ));
                  }
                  // Get.to(ProductDetails());
                },
                child: Container(
                  height: 92,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: menuitemdata.logo == null
                        ? Center(
                            child: Image.asset(
                              "assets/icons/image.png",
                              scale: 5,
                            ),
                          )
                        : Image.network(menuitemdata.logo, fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                            return Center(
                                child: Image.asset(
                              "assets/icons/image.png",
                              scale: 5,
                            ));
                          }
                            // loadingBuilder: (context, child, progress) {
                            //   return progress == null
                            //       ? child
                            //       : LinearProgressIndicator();
                            // },
                            ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5),

                //width: 30,
                height: 24,
                decoration: BoxDecoration(
                    color: Color(Helper.getHexToInt("#FFF7E4")),
                    // color: Colors.green,
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  "\$" + menuitemdata.price.toString(),
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
              left: 100,
              child: Container(
                child: Text(
                  menuitemdata.title,
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
              right: 20,
              child: Container(
                child: Text(
                  menuitemdata.subTxt,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'TTCommonsm',
                    color:
                        Color(Helper.getHexToInt("#6E6E6E")).withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 10,
                left: 100,
                height: 27,
                width: 120,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (menuitemdata.pqty > 1) {
                              menuitemdata.pqty.value--;
                              print("remove");
                              cartController.isInChart(shopid, menuitemdata);
                            }
                            // Get.find<MenuController>().decrement(menuitemdata.id);
                            // cartController.decrement();
                          },
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: Color(Helper.getHexToInt("#6E6E6E")),
                            ),
                          ),
                        ),
                      ),
                      // menuitemdata.qty = cartController.qty;
                      Expanded(
                        child: Container(
                          height: 25,
                          width: 18,
                          decoration: BoxDecoration(
                              color: Color(Helper.getHexToInt("#3AD8B4")),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(child: Obx(() {
                            menuitemdata.qty = cartController.qty.value;

                            return Text(
                              // cartController.qty.value.toString(),
                              menuitemdata.pqty.toString(),
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'TTCommonsd',
                                  color: Colors.white),
                            );
                          })),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: InkWell(
                          onTap: () {
                            // Get.find<MenuController>().increment(menuitemdata.id);
                            menuitemdata.pqty.value++;
                            // cartController.increment(menuitemdata.id);
                            print("add");
                            cartController.isInChart(shopid, menuitemdata);
                          },
                          child: Center(
                              child: Icon(
                            Icons.add,
                            size: 20,
                            color: Color(Helper.getHexToInt("#6E6E6E")),
                          )),
                        ),
                      ))
                    ],
                  ),
                )),
            Positioned(
              bottom: 10,
              left: 250,
              child: InkWell(
                onTap: () {
                  if (menuitemdata.sizes.length != 0 ||
                      menuitemdata.colors.length != 0) {
                    Get.to(ProductDetails(
                      menuitemdata: menuitemdata,
                      shopid: shopid,
                      vat: vat,
                      deliveryCharge: deliveryCharge,
                    ));
                  } else {
                    menuitemdata.qty = menuitemdata.pqty.toInt();
                    cartController.additemtocarts(
                        menuitemdata, shopid, vat, deliveryCharge);

                    // GetStorage box = GetStorage();
                    // box.write("cartList", Get.find<CartController>().cartList);
                    // box.write("shopid", shopid);
                    // box.write("vat", vat);
                    // box.write("deliveryCharge", deliveryCharge);
                    // print(vat);
                    // box.write("shopid", shopid);
                    // print("object");
                    cartController.isInChart(shopid, menuitemdata);
                  }
                },
                child: Container(
                  height: 25,
                  width: 28,
                  decoration: BoxDecoration(
                      color: Color(Helper.getHexToInt("#3AD8B4")),
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.shopping_basket,
                    size: 20,
                    color: Colors.white,
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
