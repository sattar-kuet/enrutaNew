import 'dart:convert';
import 'dart:math';

import 'package:enruta/api/service.dart';
import 'package:enruta/controllers/loginController/loginController.dart';
import 'package:enruta/controllers/menuController.dart';
import 'package:enruta/controllers/suggestController.dart';
import 'package:enruta/controllers/textController.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/model/Product_model.dart';

import 'package:enruta/model/sendOrder.dart';
import 'package:enruta/screen/cart/cart_model.dart';
import 'package:enruta/screen/cartPage.dart';
import 'package:enruta/screen/homePage.dart';

import 'package:enruta/screen/voucher/voucher_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as h;
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  var position = 0.obs;
  var qty = 0.obs;
  var vat = 0.obs;
  var deliveryCharge = 0.obs;
  var grandTotal = 0.obs;
  var shoptype = "assets/images/type0.jpg".obs;
  var imageloader = false.obs;
  // ignore: deprecated_member_use
  var cartList = List<Product>().obs;
  // var paymentOption = ''.obs;
  // ignore: non_constant_identifier_names
  var shop_category = ''.obs;
  var deliverOption = ''.obs;
  // ignore: non_constant_identifier_names
  var user_id = ''.obs;
  var order = SendOrderModel();
  var newOrder = 0.obs;
  var cupontype = 0.obs;

  // final menuController = Get.put(MenuController()).obs;
  // ignore: deprecated_member_use
  var menuItems = List<Product>().obs;
  // ignore: deprecated_member_use
  var menuItemsTemp = List<Product>().obs;
  var categoryName = ''.obs;
  // ignore: deprecated_member_use
  var cartLists = List<Product>().obs;

  var deliveryType = 0.obs;
  var logCont = Get.put(LoginController());
  RxList<CartItemModel> items = RxList<CartItemModel>([]);
  // var cartL = List<Product>().obs;

  RxList<CartItemModel> cartItems = RxList<CartItemModel>([]);

  int get count => cartList.length;
  var subTprice = 0.0.obs;
  var tvatprice = 0.0.obs;
  var grandTotalprice = 0.0.obs;
  var tax = 0.obs;

  var cuppon = 0.0.obs;
  var cuponholder = 0.0.obs;
  var cupponMinimum = 0.obs;
  //for voucher
  var shopvoucher = 0.obs;
  var voucher = 0.obs;

  var voucherMinimum = 0.obs;

  var isLoding = false.obs;
  var submitorderstatus = false.obs;

  //for offer
  var discount = 0.obs;
  var minimumSpent = 0.obs;
  var offer = 0.obs;

  var checkOffer = 0.obs;
  var underValue = 0.obs;
  var cuponerrortxt = "".obs;

  double get totalPrice =>
      cartList.fold(0, (sum, item) => sum + item.price * item.qty);

  double get vatPrice => totalPrice * vat.value / 100;

  double get gTotal {
    var a = totalPrice +
        vatPrice +
        deliveryCharge.value -
        cuppon.value -
        voucher.value -
        discount.value;
    int fac = pow(10, 2);
    a = (a * fac).round() / fac;
    return a;
  }
  // voucherMinimum.value>totalPrice?

  int get countqty => cartList.first.qty;
  var selectAddress = "".obs;
  var selectLat = "".obs;
  var selectLng = "".obs;
  var shopid = "".obs;

  var paymentoption = "".obs;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    totalcalculate();
    GetStorage box = GetStorage();
    if (shopid.value == null) {
      checkshopid();
    }

    if (box.read("selectAddress") != null) {
      selectAddress.value = box.read("selectAddress");
    }
    if (box.read("selectLet") != null) {
      selectLat.value = box.read("selectLet");
      selectLng.value = box.read("selectLng");
    }
    if (box.read("paymentoption") != null) {}

    getsuggetItems();
    print("Menu items fn called");

    List storedCartList = GetStorage().read<List>('cartList');
    // shopid.value = GetStorage().read('shopid');

    if (!storedCartList.isNull) {
      cartList = storedCartList.map((e) => Product.fromJson(e)).toList().obs;
    }
    if (shopid != null && cartList.length < 0) {
      box.remove("shopid");
      print("remove");
    }
    ever(cartList, (_) {
      GetStorage().write('cartList', cartList.toList());
    });
    removeShopID();

    super.onInit();
  }

  // ignore: deprecated_member_use
  var suggetItems = List<Product>().obs;
  var isLoading = true.obs;

  void getsuggetItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopid.value = prefs.getString('shopid');
    print("shopid");
    shopid.value = box.read("shopid");
    print(shopid.value);
    try {
      suggetItems.value = [];
      isLoading(true);
      // await Future.delayed(Duration(seconds: 1));
      Service.menulist(shopid.value).then((val) {
        if (val != null) {
          suggetItems.value = val.products.toList();
          print(suggetItems.length);
        }
      });
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  void additemtocarts(
      Product item, String shop, int vats, int deliveryC) async {
    print("shopid" '$shop');
    print(vats);
    print("deliveryC");
    print("ADD ITEM TO CARD CALLED");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopid.value = prefs.getString('shopid');
    print("shop id is " '${shopid.value}');

    if (shopid.value == null) {
      prefs.setString('shopid', shop);
      prefs.setInt("vat", vats);
      prefs.setInt("deliveryCharge", deliveryC);
      vat.value = vats;
      deliveryCharge.value = deliveryC;
      print("............working so far......");
      productadded(item, shop);
    } else if (shopid.value != null && shopid.value != shop) {
      Get.defaultDialog(
          title: "",
          content: Text(
              "Your previous cart will be cleared if you proceed with this shop"),
          actions: [
            // ignore: deprecated_member_use
            RaisedButton(
                child: Text("Cancel"),
                color: Colors.redAccent,
                onPressed: () {
                  Get.back();
                }),
            // ignore: deprecated_member_use
            RaisedButton(
                child: Text("Ok"),
                color: theamColor,
                onPressed: () {
                  // ignore: deprecated_member_use
                  cartList.value = List<Product>().obs;
                  prefs.setString('shopid', shop);
                  prefs.setInt("vat", vats);
                  prefs.setInt("deliveryCharge", deliveryC);
                  voucher.value = 0;
                  cuppon.value = 0.0;
                  prefs.setString("categoryName",
                      Get.find<MenuController>().categoryName.value);
                  Get.find<SuggestController>().getsuggetItems();
                  Get.find<SuggestController>().removeitemfromlist(item.id);
                  totalcalculate();
                  vat.value = vats;
                  deliveryCharge.value = deliveryC;
                  shopid.value = shop;
                  Get.back();
                  productadded(item, shop);

                  //getplist();
                })
          ]);
    } else if (shopid.value == shop) {
      print("*********from Add to cart ********* ${item.selectcolor}");
      productadded(item, shop);
    }
  }

  void getplist() {
    print(".....plist called...");

    List storedCartList = GetStorage().read<List>('cartList');

    // try {
    //   storedCartList.map((e) => print("abc"));
    // } catch (e) {
    //   print("eror abc");
    // }

    // if (storedCartList.length > 0) {
    //   // ignore: deprecated_member_use
    //   cartList = List<Product>().obs;

    //   cartList = storedCartList.map((e) => Product.fromJson(e)).toList().obs;
    //   // storedCartList.map((e) => Product.fromJson(e)).toList().obs;

    //   print(cartList.toList());
    // }
    ever(cartList, (_) {
      GetStorage().write('cartList', cartList.toList());
    });
  }

  void productadded(Product item, String shop) async {
    print(item.selectcolor);

    print("Product Added Called............ + color : ${item.toJson().values}");

    GetStorage box = GetStorage();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    checkshopId(shop);
    // prefs.getString("shopid");
    // if (shopid.value != null) {
    var check = false;
    if (cartList.length == 0) {
      Get.snackbar(
        "",
        "item added",
        colorText: Colors.white,
      );
      cartList.add(item);
      print("cart len 0");
      print(jsonEncode(cartList));
      box.write("shopcategory", categoryName.value);
      box.write("cartList", cartList);
      Get.find<SuggestController>().removeitemfromlist(item.id);
      var a = box.read("shopcategory");
      print("sssssss" + a);
      totalcalculate();

      getplist();
      check = true;
      print("when 0 ");
    } else {
      //cartList.add(item);
      print("cart len >0");

      for (var i = 0; i < cartList.length; i++) {
        if (item.id != 0 && item.id == cartList[i].id) {
          // ignore: invalid_use_of_protected_member
          cartList.value[i].qty = item.qty;
          // cartList.value[i].selectcolor = item.selectcolor;
          // cartList.value[i].selectSize = item.selectSize;
          // Get.snackbar(" add", "item alrady added");
          Get.snackbar(
            "Cart",
            "Added to cart",
            colorText: Colors.white,
          );
          check = true;
          return;
        }
      }
      print(jsonEncode(cartList));
    }
    // ignore: invalid_use_of_protected_member
    print("value value value" + '${cartList.value}');
    if (check == false) {
      cartList.add(item);
      print("cart check false");
      print(jsonEncode(cartList));

      box.write("cartList", Get.find<CartController>().cartList);
      Get.find<SuggestController>().removeitemfromlist(item.id);
      totalcalculate();
      getplist();
      Get.snackbar(
        " add",
        "item added",
        colorText: Colors.white,
      );
    }
  }

  Future<bool> isInChart(String shopId, Product item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String shop = prefs.getString('shopid');
    bool result = false;
    if (shop != null &&
        int.parse(shop) == int.parse(shopId) &&
        cartList.length != 0) {
      for (Product p in cartList) {
        if (item.id != 0 && item.id == p.id) {
          if (p.qty == item.pqty.value) {
            result = true;
          }
        }
      }
    }
    print("Shop:" + shopId + " Item:" + item.title + " :$result");
    return result;
  }

  /// /// ///

  void addtocart(Product item, String s) {
    GetStorage box = GetStorage();
    shopid.value = box.read("shopid");
    print(shopid.value);
    if (shopid == null) {
      box.write('shopid', s);
      print(shopid);
    }

    if (shopid.value != null && shopid.value != s) {
      print("trurkjkj");

      Get.defaultDialog(
          title: "",
          content: Text(
              "Your previous cart will be cleared if you proceed with this shop"),
          actions: [
            // ignore: deprecated_member_use
            RaisedButton(
                child: Text("Cancel"),
                color: Colors.redAccent,
                onPressed: () {
                  Get.back();
                }),
            // ignore: deprecated_member_use
            RaisedButton(
                child: Text("Ok"),
                color: theamColor,
                onPressed: () {
                  GetStorage().remove('cartList');
                  Get.back();
                  print(box.read("shopid"));
                  cartList.value = box.read('cartList');
                  // ignore: deprecated_member_use
                  cartList.value = List<Product>();
                })
          ]);
    } else {
      print(shopid);

      checkshopId(s);
      var check = false;
      if (cartList.length == 0) {
        Get.snackbar(
          " add",
          "item added",
          colorText: Colors.white,
        );
        cartList.add(item);
        print("when 0");
      }
      for (var i = 0; i < cartList.length; i++) {
        // print(cartList[i].id + item.id);
        if (item.id == cartList[i].id) {
          Get.snackbar(
            " add",
            "item alrady added",
            colorText: Colors.white,
          );
          // print(cartList[i].id + item.id);
          check = true;
          // return;
        }
      }
      if (check == false) {
        cartList.add(item);
        Get.snackbar(
          " add",
          "item added",
          colorText: Colors.white,
        );
      }
    }
  }

  bool checkshopId(String id) {
    shopid.value = GetStorage().read('shopid');
    return true;
  }

  void removeShopID() {
    print(cartList.length);
    if (cartList.length == 0) {
      GetStorage box = GetStorage();
      box.remove("shopid");
      // print("sdfsdfsdf");
      // print(box.read("shopid"));
    }
  }

  void addtocarts(Product item) {
    var check = false;
    if (cartList.length == 0) {
      cartList.add(item);
      print("when 0");
    }
    // ignore: invalid_use_of_protected_member
    for (var i = 0; i < menuItems.value.length; i++) {
      // ignore: invalid_use_of_protected_member
      if (menuItems.value[i].id == item.id) {
        // ignore: invalid_use_of_protected_member
        menuItems.value[i].pqty.value = item.qty;
        // ignore: invalid_use_of_protected_member
        // menuItems.value[i].selectcolor = item.selectSize;
        // // ignore: invalid_use_of_protected_member
        // menuItems.value[i].selectSize = item.selectcolor;
      }
    }

    for (var i = 0; i < cartList.length; i++) {
      print(cartList[i].id + item.id);
      if (item.id == cartList[i].id) {
        print(cartList[i].id + item.id);
        check = true;
        // return;
      }
    }
    if (check == false) {
      cartList.add(item);
    }
  }

  Future<void> applyVoucher(String code) async {
    print("Shop id = $shopid from apply voucher");
    underValue.value = 0;
    CuponModel a = await Service.getCuppons(shopid.value, user_id.value, code);
    try {
      if (!a.offer.isNull) {
        cupponMinimum.value = a.offer.minimum_spent;
        cupontype.value = a.offer.type;
        if (cupontype.value == 1) {
          cuponholder.value = a.offer.discount.toDouble();
          print("c holder type 0 ${cuponholder.value}");
        } else if (cupontype.value == 2) {
          cuponholder.value = (subTprice * a.offer.discount) / 100;
          print("c holder type 1 ${cuponholder.value}");
        }
      }
    } catch (e) {
      cuponerrortxt.value = "wrong coupon code";

      checkOffer.value = 1;
      cuponholder.value = 0;
      cuppon.value = 0.0;
      print("check offer ${checkOffer.value}");
      print(cuponerrortxt.value);
    }
  }

  void totalcalculate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var pk = voucherMinimum.value.toDouble();

    if (totalPrice > voucherMinimum.value) {
      voucher.value = shopvoucher.value;
    } else {
      voucher.value = 0;
    }
    if (totalPrice > cupponMinimum.value) {
      //checkOffer.value = 0;
    } else {
      cuponerrortxt.value = "Minimum ammout is $cupponMinimum";
      print(cuponerrortxt.value);
      cuponholder.value = 0;
      checkOffer.value = 1;
      cupponMinimum.value = 0;
    }

    if (totalPrice > minimumSpent.value) {
      discount.value = offer.value;
    } else {
      discount.value = 0;
    }

    subTprice.value = totalPrice;
    tvatprice.value = vatPrice;
    cuppon.value = cuponholder.value;
    if (cuppon.value != 0) {
      Get.snackbar(
        "Couppon",
        "Applied",
        colorText: Colors.white,
      );
    }
    grandTotalprice.value = gTotal;
    shopid.value = prefs.getString("shopid");
    print("totalcalculate working");
    print(vat.value);
  }

  void checkshopid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopid.value = prefs.getString("shopid");
  }

  setdeleveryAddress({var addressdetails, var lat, var long}) {
    // GetStorage box = GetStorage();
    // // print(a);
    // // print(b);
    // // print(c);
    // List<AddressModel> addresslist =
    //     box.read('addressList') ? box.read('addressList') : [];

    box.write("selectLet", lat.toString());
    box.write("selectLng", long.toString());
    print("lat lang written finished");
    box.write("adress_list", addressdetails);

    selectAddress.value = addressdetails.toString();
    selectLat.value = lat.toString();
    selectLng.value = long.toString();

    print("from set -- ${selectAddress.value}");
    Get.put(TestController()).getLocation();

    Get.back();
  }

  setpayment(var payment) {
    GetStorage box = GetStorage();
    box.write("paymentoption", payment);
    paymentoption.value = payment;
  }

  setqty(Product p) {
    try {
      for (var i = 0; i < cartList.length; i++) {
        if (p.id == cartList[i].id) {
          cartList[i].qty = p.qty;
        }
      }
    } catch (e) {}
  }

  sendOrder(BuildContext context) async {
    print(jsonEncode(cartList));
    isLoding.value = true;
    GetStorage box = GetStorage();
    SharedPreferences pre = await SharedPreferences.getInstance();
    SendOrderModel sendOrder = new SendOrderModel();
    //Item p = new Item();
    // var pList = List<Item>();
    List<Item> pList = [];

    user_id.value = pre.getString("email");

    deliveryCharge.value = deliveryCharge.value;

    grandTotal.value = gTotal.round();

    shop_category.value = shopid.value;

    tax.value = vatPrice.toInt();

    sendOrder.userId = pre.getInt("id");
    if (sendOrder.userId == null) {
      logCont.checklogin();
    }
    sendOrder.shopCategory = pre.getString("categoryName");
    // if(sendOrder.shopCategory.isEmpty){
    sendOrder.shopCategory = box.read("shopcategory");
    // }

    sendOrder.lat = selectLat.value.toString();

    sendOrder.lng = selectLng.value.toString();
    //print("cartListcartListcartListcartList" + cartList.value.toString());
    for (var item in cartList) {
      Item p = new Item();
      p.productId = item.id;
      p.qty = item.qty;
      p.price = item.price.toDouble();
      p.size = item.selectSize != null ? item.selectSize : "";
      p.color = item.selectcolor != null ? item.selectcolor : "";

      pList.add(p);
      // order.items.add(item);
    }
    sendOrder.items = pList.toList();
    // print("cartListcartListcartListcartList" + sendOrder.items[0].color);
    // order.items = cartList.toList();

    // order.items = cartList.toList();

    sendOrder.tax = vatPrice;
    sendOrder.coupon = cuppon.value ?? 0.0;
    sendOrder.voucher = voucher.value ?? 0;
    sendOrder.offer = discount.value ?? 0;

    sendOrder.deliveryCharge = deliveryCharge.value.toDouble();

    sendOrder.paymentOption = paymentoption.value.toString();

    newOrder.value = 1;
    print(pList);

    //await Future.delayed(Duration(seconds: 1));

    Service.sendorder(sendOrder).then((values) {
      h.Response res = values;
      //String responseCode = res.statusCode.toString();
      if (res.statusCode == 200) {
        submitorderstatus.value = true;
        sendOrder = new SendOrderModel();
        pList = [];
        cartList.value = [];
        print(cartList);
        clearall();
        var c = CartPage();

        Navigator.pop(context);
        c.showSuccessfullyBottompopup(context);
      }

      print(res.body);
      print(res.body);

      // Get.back();
      isLoding.value = false;
    });
  }

  // increment() => qty++;
  void gobackhomePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopid.value = prefs.getString('shopid');
    prefs.remove("shopid");
    shopid.value = prefs.getString('shopid');

    print(shopid.value.toString());

    Get.offAll(HomePage());
  }

  void clearall() {
    deliveryCharge.value = 0;

    grandTotal.value = 0;
    subTprice.value = 0;
    tvatprice.value = 0;
    deliveryCharge.value = 0;
    cuppon.value = 0.0;
    voucher.value = 0;
    discount.value = 0;
    grandTotalprice.value = 0;
    tax.value = 0;
    grandTotal.value = 0;
    cupponMinimum.value = 0;
    cuponholder.value = 0;
  }

  increment(int id) {
    qty++;
  }

  decrement() {
    if (qty > 0) {
      qty--;
    }
  }

  void getcoverPic(var id) async {
    print(".....Shop cat id......");
    try {
      //await Future.delayed(Duration(seconds: 1));
      Service.menulist(id).then((va) {
        if (va != null) {}
      });
    } catch (e) {
      print(e);
    }
  }

  void getmenuItems(var id) async {
    // SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      menuItems.value = [];
      isLoading(true);
      imageloader(true);
      // await Future.delayed(Duration(seconds: 1));
      Service.menulist(id).then((va) {
        if (va != null) {
          shoptype.value = "assets/images/type${va.shopCategory}.jpg";

          menuItemsTemp.value = va.products.toList();
          categoryName.value = va.categoryName.toString();

          print(menuItemsTemp.length);
          // ignore: invalid_use_of_protected_member
          cartLists.value = cartList.value.toList();
          // ignore: invalid_use_of_protected_member
          if (cartList.value.length > 0) {
            // ignore: invalid_use_of_protected_member
            for (var j = 0; j < menuItemsTemp.value.length; j++) {
              for (var i = 0; i < cartList.length; i++) {
                // ignore: invalid_use_of_protected_member
                if (menuItemsTemp.value[j].id != 0 &&
                    // ignore: invalid_use_of_protected_member
                    menuItemsTemp.value[j].id == cartList[i].id) {
                  // cartList.value[i].qty =item.qty;
                  // ignore: invalid_use_of_protected_member
                  menuItemsTemp.value[j].pqty.value = cartList[i].qty;
                  // Get.snackbar(" add", "item alrady added");

                }
              }
            }
          }
          // ignore: invalid_use_of_protected_member
          menuItems.value = menuItemsTemp.value;

          // update();

        } else {
          shoptype.value = "assets/images/type0.jpg";
        }
      });
    } catch (e) {
      shoptype.value = "assets/images/type0.jpg";
      imageloader(false);
    } finally {
      //print("get menu api end");

      isLoading(false);
      await Future.delayed(Duration(milliseconds: 2000));
      imageloader(false);
    }
  }
}

extension NumberParsing on String {
  double toDouble() {
    return double.parse(this);
  }
}
