
import 'package:enruta/api/service.dart';
import 'package:enruta/controllers/loginController/loginController.dart';
import 'package:enruta/controllers/menuController.dart';
import 'package:enruta/controllers/suggestController.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/model/Product_model.dart';
import 'package:enruta/model/sendOrder.dart';
import 'package:enruta/screen/cart/cart_model.dart';
import 'package:enruta/screen/cartPage.dart';
import 'package:enruta/screen/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  var position = 0.obs;
  var qty = 0.obs;
  var vat = 0.obs;
  var deliveryCharge = 0.obs;
  var grandTotal = 0.obs;
  // ignore: deprecated_member_use
  var cartList = List<Product>().obs;
  // var paymentOption = ''.obs;
  var shop_category = ''.obs;
  var deliverOption = ''.obs;
  var user_id = ''.obs;
  var order = SendOrderModel();
  var newOrder = 0.obs;

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

  var cuppon = 0.obs;
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

  double get totalPrice =>
      cartList.fold(0, (sum, item) => sum + item.price * item.qty);

  double get vatPrice => totalPrice * vat.value / 100;

  double get gTotal =>
      totalPrice +
      vatPrice +
      deliveryCharge.value -
      cuppon.value -
      voucher.value -
      discount.value;
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
      await Future.delayed(Duration(seconds: 1));
      Service.menulist(shopid.value).then((val) {
       if(val != null){
         suggetItems.value = val.products.toList();
         print(suggetItems.length);
       }
      });
    } catch (e) {}
    finally {
      isLoading(false);
    }
  }

  void additemtocarts(Product item, String shop, int vats, int deliveryC) async {
    print("shopid" '$shop');
    print(vats);
    print(deliveryC);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopid.value = prefs.getString('shopid');
    print("shop id is " '${shopid.value}');

    if (shopid.value == null) {
      prefs.setString('shopid', shop);
      prefs.setInt("vat", vats);
      prefs.setInt("deliveryCharge", deliveryC);
      vat.value = vats;
      deliveryCharge.value = deliveryC;
      productadded(item, shop);
    } else if (shopid.value != null && shopid.value != shop) {
      Get.defaultDialog(
          title: "",
          content: Text(
              "Your previous cart will be cleared if you proceed with this shop"),
          actions: [
            RaisedButton(
                child: Text("Cancel"),
                color: Colors.redAccent,
                onPressed: () {
                  Get.back();
                }),
            RaisedButton(
                child: Text("Ok"),
                color: theamColor,
                onPressed: () {
                  cartList.value = List<Product>().obs;
                  prefs.setString('shopid', shop);
                  prefs.setInt("vat", vats);
                  prefs.setInt("deliveryCharge", deliveryC);
                  voucher.value = 0;
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

                  getplist();
                })
          ]);
    } else if (shopid.value == shop) {
      productadded(item, shop);
    }
  }

  void getplist() {
    List storedCartList = GetStorage().read<List>('cartList');
    print(storedCartList);

    if (storedCartList.length > 0) {
      cartList = List<Product>().obs;
      cartList = storedCartList.map((e) => Product.fromJson(e)).toList().obs;
      print(cartList.toList());
    }
    ever(cartList, (_) {
      GetStorage().write('cartList', cartList.toList());
    });
  }

  void productadded(Product item, String shop) async {
    GetStorage box = GetStorage();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    checkshopId(shop);
    // prefs.getString("shopid");
    // if (shopid.value != null) {
    var check = false;
    if (cartList.length == 0) {
      Get.snackbar(" add", "item added");
      cartList.add(item);
      box.write("shopcategory", categoryName.value);
      box.write("cartList", Get.find<CartController>().cartList);
      Get.find<SuggestController>().removeitemfromlist(item.id);
      var a= box.read("shopcategory");
      print("sssssss"+a);
      totalcalculate();
      getplist();
      check = true;
      print("when 0");
    } else {
      for (var i = 0; i < cartList.length; i++) {
        if (item.id != 0 && item.id == cartList[i].id) {
          cartList.value[i].qty =item.qty;
          // Get.snackbar(" add", "item alrady added");
          Get.snackbar("update", "item qty update");
          check = true;
          return;
        }
      }
    }
    print("value value value"+ '${cartList.value}');
    if (check == false) {
      cartList.add(item);

      box.write("cartList", Get.find<CartController>().cartList);
      Get.find<SuggestController>().removeitemfromlist(item.id);
      totalcalculate();
      getplist();
      Get.snackbar(" add", "item added");
    }
  }

  Future<bool> isInChart(String shopId, Product item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String shop = prefs.getString('shopid');
    bool result = false;
    if (shop != null && int.parse(shop) == int.parse(shopId) && cartList.length != 0) {
      for (Product p in cartList) {
        if (item.id != 0 && item.id == p.id) {
          if (p.qty == item.pqty.value){
            result = true;
          }
        }
      }
    }
    print("Shop:"+shopId+" Item:"+item.title+" :$result");
    return result;
  } /// /// ///

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
            RaisedButton(
                child: Text("Cancel"),
                color: Colors.redAccent,
                onPressed: () {
                  Get.back();
                }),
            RaisedButton(
                child: Text("Ok"),
                color: theamColor,
                onPressed: () {
                  GetStorage().remove('cartList');
                  Get.back();
                  print(box.read("shopid"));
                  cartList.value = box.read('cartList');
                  cartList.value = List<Product>();
                })
          ]);
    } else {
      print(shopid);

      checkshopId(s);
      var check = false;
      if (cartList.length == 0) {
        Get.snackbar(" add", "item added");
        cartList.add(item);
        print("when 0");
      }
      for (var i = 0; i < cartList.length; i++) {
        // print(cartList[i].id + item.id);
        if (item.id == cartList[i].id) {
          Get.snackbar(" add", "item alrady added");
          // print(cartList[i].id + item.id);
          check = true;
          // return;
        }
      }
      if (check == false) {
        cartList.add(item);
        Get.snackbar(" add", "item added");
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
    for(var i = 0; i<menuItems.value.length; i++){
      if(menuItems.value[i].id == item.id){
        menuItems.value[i].pqty.value = item.qty;
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

  void totalcalculate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var pk = voucherMinimum.value.toDouble();

    if (totalPrice > voucherMinimum.value) {
      voucher.value = shopvoucher.value;
    } else {
      voucher.value = 0;
    }

    if (totalPrice > minimumSpent.value) {
      discount.value = offer.value;
    } else {
      discount.value = 0;
    }

    subTprice.value = totalPrice;
    tvatprice.value = vatPrice;
    grandTotalprice.value = gTotal;
    shopid.value = prefs.getString("shopid");
    print("totalcalculate working");
    print(vat.value);
  }

  void checkshopid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopid.value = prefs.getString("shopid");
  }

  setAddress(var a, var b, var c) {
    GetStorage box = GetStorage();
    print(a);
    print(b);
    print(c);

    box.write("selectLet", b);
    box.write("selectLng", c);
    selectAddress.value = a;
    selectLat.value = b;
    selectLng.value = c;

    print(a);

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
    isLoding.value = true;
    GetStorage box = GetStorage();
    SharedPreferences pre = await SharedPreferences.getInstance();
    SendOrderModel sendOrder = new SendOrderModel();
    Item p = new Item();
    // var pList = List<Item>();
    List<Item> pList = [];

    user_id.value = pre.getString("email");

    
    deliveryCharge.value = deliveryCharge.value;

    grandTotal.value = gTotal.round();

    shop_category.value = shopid.value;

    tax.value = vatPrice.toInt();

    sendOrder.userId = pre.getInt("id");
    if(sendOrder.userId==null){
      logCont.checklogin();
    }
    sendOrder.shopCategory = pre.getString("categoryName");
    // if(sendOrder.shopCategory.isEmpty){
      sendOrder.shopCategory = box.read("shopcategory");
    // }

    sendOrder.lat = selectLat.value.toString();

    sendOrder.lng = selectLng.value.toString();
print("cartListcartListcartListcartList"+cartList.value.toString());
    for (var item in cartList) {
      Item p = new Item();
      p.productId = item.id;
      p.qty = item.qty;
      p.price = item.price.toDouble();

      pList.add(p);
      // order.items.add(item);
    }
    sendOrder.items = pList.toList();
    print("cartListcartListcartListcartList"+sendOrder.items.toString());
    // order.items = cartList.toList();

    // order.items = cartList.toList();

    sendOrder.tax = vatPrice;
    sendOrder.coupon = cuppon.value ?? 0;
    sendOrder.voucher = voucher.value ?? 0;
    sendOrder.offer = discount.value ?? 0;

    sendOrder.deliveryCharge = deliveryCharge.value.toDouble();

    sendOrder.paymentOption = paymentoption.value.toString();

    newOrder.value = 1;

    await Future.delayed(Duration(seconds: 1));

    Service.sendorder(sendOrder).then((values) {
      Response res = values;
      String responseCode = res.statusCode.toString();
      if(res.statusCode==200){
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
void gobackhomePage() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  shopid.value = prefs.getString('shopid');
  prefs.remove("shopid");
  shopid.value = prefs.getString('shopid');

  print(shopid.value.toString());

    Get.offAll(HomePage());
}



  void clearall (){
    deliveryCharge.value = 0;

    grandTotal.value = 0;
    subTprice.value = 0;
    tvatprice.value = 0 ;
    deliveryCharge.value =0;
    cuppon.value = 0;
    voucher.value = 0;
    discount.value = 0;
    grandTotalprice.value= 0;
    tax.value = 0;
    grandTotal.value = 0;

  }

  increment(int id) {
    qty++;
  }

  decrement() {
    if (qty > 0) {
      qty--;
    }
  }

  void getmenuItems(var id) async {
    // SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      menuItems.value = [];
      isLoading(true);
      await Future.delayed(Duration(seconds: 1));
      Service.menulist(id).then((va) {
        if(va != null){
          menuItemsTemp.value = va.products.toList();
          categoryName.value = va.categoryName.toString();
          print(menuItemsTemp.length);
          cartLists.value = cartList.value.toList();
          if(cartList.value.length>0){
            for(var j=0; j<menuItemsTemp.value.length; j++){
              for (var i = 0; i < cartList.length; i++) {
                if (menuItemsTemp.value[j].id != 0 && menuItemsTemp.value[j].id == cartList[i].id) {
                  // cartList.value[i].qty =item.qty;
                  menuItemsTemp.value[j].pqty.value = cartList[i].qty;
                  // Get.snackbar(" add", "item alrady added");

                }
              }
            }

          }
          menuItems.value = menuItemsTemp.value;
          // update();



        }
      });
    } catch (e) {} finally {
      isLoading(false);
    }
  }



}

extension NumberParsing on String {
  double toDouble() {
    return double.parse(this);
  }
}
