import 'package:enruta/controllers/cartController.dart';
import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/controllers/menuController.dart';
import 'package:enruta/controllers/suggestController.dart';
import 'package:enruta/helper/_SliverAppBarDelegate.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/model/rating_list_data.dart';
import 'package:enruta/model/review_list_data.dart';
import 'package:enruta/screen/resetpassword/resetController.dart';
import 'package:enruta/view/rating_list_view.dart';
import 'package:enruta/view/review_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'cartPage.dart';

// ignore: must_be_immutable
class MenuAndReviewPage extends StatelessWidget {
  final mController = Get.put(MenuController());
  final cartCont = Get.put(CartController());
  final SuggestController suggestCont = Get.put(SuggestController());
  // ignore: non_constant_identifier_names
  var shop_id = 0;
  // ignore: non_constant_identifier_names
  var shop_name = "";
  var vat = 0;
  var deliveryCharge = 0;
  var address = '';
  String time;

  MenuAndReviewPage(this.shop_id, this.vat, this.deliveryCharge, this.shop_name,
      [this.address, this.time]);

  List<ReviewListData> reviewList;
  List<RatingListData> ratingList = RatingListData.ratingList;

  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ResetController());
    reviewList = ReviewListData.reviewList;
    print(shop_id);
    cartCont.getmenuItems(shop_id);

    mController.getreview(shop_id);
    print(" shop type  ${cartCont.shoptype}");
    print("cover = ${cartCont.menucover}");

    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading: InkWell(
                      onTap: () {
                        Get.back();
                        // Get.back()
                        // Get.off(CategoryPage());
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),

                    // title: Text('2060  LA Colendge, BLvd 2.1 Miles- Fast Food'),
                    expandedHeight: 220.0,
                    floating: false,
                    pinned: true,
                    // forceElevated: innerBoxIsScrolled,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        gradient:
                            LinearGradient(begin: Alignment.topLeft, colors: [
                          Color(Helper.getHexToInt("#11C7A1")),
                          // Colors.green[600],
                          Color(Helper.getHexToInt("#11E4A1"))
                        ]),
                      ),
                      child: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          this.address ??
                              '2060  LA Colendge, BLvd 2.1 Miles- Fast Food ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'TTCommonsd',
                            fontSize: 11,
                          ),
                        ),
                        background: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                          // child: Opacity(
                          //   opacity: 0.5,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Obx(() {
                                    if (cartCont.menucover.value == "" ||
                                        cartCont.menucover == null) {
                                      if (cartCont.imageloader.value) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                          backgroundColor: Colors.black,
                                        ));
                                      } else
                                        return Opacity(
                                          opacity: 1,
                                          child: Image.asset(
                                            cartCont.shoptype.value,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                    } else {
                                      return Opacity(
                                        opacity: 1,
                                        child: Image.network(
                                          cartCont.menucover.value,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace stackTrace) {
                                            return Center(
                                                child: Image.asset(
                                              "assets/icons/image.png",
                                              scale: 5,
                                            ));
                                          },
                                          loadingBuilder:
                                              (context, child, progress) {
                                            return progress == null
                                                ? child
                                                : Center(
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator()));
                                          },
                                        ),
                                      );
                                    }
                                  })),
                              Positioned(
                                top: 0,
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  color: Color(Helper.getHexToInt("#000000"))
                                      .withOpacity(.5),
                                ),
                              ),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  right: 50,
                                  bottom: 50,
                                  child: Container(
                                      color: Colors.transparent,
                                      child: Center(
                                        child: Text(
                                          this.shop_name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontFamily: 'TTCommonsm',
                                          ),
                                        ),
                                      )
                                      // child: Image.asset(
                                      //     'assets/icons/shoplogo.png')),
                                      )),
                            ],
                          ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    floating: false,
                    pinned: true,
                    delegate: SliverAppBarDelegate(
                      TabBar(
                        // controller: _tabController,

                        indicatorWeight: 1.0,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.0),
                        indicatorColor: Color(Helper.getHexToInt("#11C4A1")),
                        labelColor: Colors.black,
                        unselectedLabelColor:
                            Color(Helper.getHexToInt("#7C7C7F")),
                        tabs: [
                          Tab(text: text('menu_items')),
                          Tab(text: text('reviews_&_ratings')),
                          // Tab(text: 'third')
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  Container(
                    color: cardbackgroundColor,
                    child: Stack(
                      children: [
                        Obx(() {
                          //cartCont.getmenuItems(shop_id);
                          if (cartCont.isLoading.value) {
                            print("card value ${cartCont.isLoading}");
                            return Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            ));
                          } else
                            return StaggeredGridView.countBuilder(
                              itemCount: cartCont.menuItems.length,
                              crossAxisCount: 1,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              itemBuilder: (context, index) {
                                print(
                                    "price = ${cartCont.menuItems[index].price}"); //menu items
                                return ReviewListView(
                                  menuitemdata: cartCont.menuItems[index],
                                  shopid: shop_id.toString(),
                                  vat: vat,
                                  deliveryCharge: deliveryCharge,
                                  // position: index,
                                );
                              },
                              staggeredTileBuilder: (index) =>
                                  StaggeredTile.fit(1),
                            );
                        }),
                        // Obx(
                        //   () => ListView.builder(
                        //       itemCount: mController.menuItems.length,
                        //       itemBuilder: (context, index) {
                        //         return ReviewListView(
                        //             reviewData: mController.menuItems[index]);
                        //       }),
                        // ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: buidbottomfield(context),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      color: cardbackgroundColor,
                      child: Obx(() {
                        if (mController.isLoading.value) {
                          print("card value ${cartCont.isLoading}");
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                          ));
                        } else
                          return StaggeredGridView.countBuilder(
                            crossAxisCount: 1,
                            itemCount: mController.reviewItems.length,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            itemBuilder: (context, index) {
                              return RatingListView(
                                ratingData: mController.reviewItems[index],
                              );
                            },
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.fit(1),
                          );
                      })),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget buidbottomfield(BuildContext context) {
    return InkWell(
      onTap: () async {
        // if (cartCont.cartList.length < 0) {
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   prefs.setString('shopid', shop_id.toString());
        //   prefs.setInt('vat', vat);
        //   prefs.setInt("deliveryCharge", deliveryCharge);
        // }
        cartCont.deleverytime.value = this.time;
        suggestCont.getsuggetItems();
        cartCont.suggestUpdate();
        // Get.find<SuggestController>().getsuggetItems();
        // Get.find<CartController>().vat.value = vat;
        // Get.find<CartController>().deliveryCharge.value = deliveryCharge;
        // print('$vat $deliveryCharge');
        Get.to(CartPage());
      },
      child: Stack(
        children: [
          Container(
            height: 60,
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
              text('VIEW_CART_&_CHECKOUT'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'TTCommons Medium',
              ),
            )),
          ),
          Positioned(
            left: 20,
            top: 15,
            child: InkWell(
              child: Container(
                alignment: Alignment.topLeft,
                // padding: EdgeInsets.only(top: 5, left: 5),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(Helper.getHexToInt("#41E9C3")),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Obx(
                  () => cartCont.cartList.length != null
                      ? Text(
                          cartCont.cartList.length.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TTCommons',
                          ),
                        )
                      : Text("0"),
                )),
              ),
            ),
          ),
          Positioned(
              right: 20,
              top: 10,
              bottom: 10,
              // child: InkWell(
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => CartPage()));
              //     },
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: white,
                  ),
                  onPressed: null)
              // )
              )
        ],
      ),
    );
  }
}
