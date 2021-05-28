import 'package:enruta/api/service.dart';
import 'package:enruta/controllers/textController.dart';
import 'package:enruta/model/all_order_model.dart';
//import 'package:enruta/model/near_by_place_data.dart';
import 'package:enruta/model/popular_shop.dart';
import 'package:enruta/screen/myMap/mapController.dart';
import 'package:enruta/screen/orderStutas/orderStatus.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderDetailsModel.dart';

class CurentOrderController extends GetxController {
  final tController = Get.put(TestController());
  // ignore: deprecated_member_use
  var allCurentOrderList = List<OrderModel>().obs;
  // ignore: deprecated_member_use
  var polularShopList = List<Datums>().obs;
  var curentOrder = OrderModel().obs;

  var gtotal = 0.0;

  @override
  void onInit() {
    getPopularOrder();
    getCurentOrder();
    super.onInit();
  }

  void getCurentOneOrder() {}

  // MyMapController  mapController =   Get.find();
  final cCont = Get.put(MyMapController());

  var isLoading = false.obs;
  var detailsModel = OrderDetailsModel().obs;
  var order = Order().obs;
  final address = ''.obs;

  void getorderStatus(int id) async {
    try {
      isLoading(true);
      await Future.delayed(Duration(seconds: 1));
      Service().getOrderDetails(id).then((values) {
        detailsModel.value.order = values.order;
        order.value = values.order;
        getpointerLocation(order.value.lat, order.value.lng);
        // cCont.getShopLocation(order.value.lat, order.value.lng);
        //   cCont.getshopsLocation(order.value.lat, order.value.lng);
        gettotal();

        Get.to(OrderStatus());
      });
    } finally {
      isLoading(false);
    }
  }

  // double get totalPrice =>
  //     cartList.fold(0, (sum, item) => sum + item.price * item.qty);
  void gettotal() {
    String a = order.value.price;
    var as = double.parse(a);

    var b = order.value.deliveryCharge;
    var c = order.value.voucher;
    var d = order.value.coupon;

    var e = order.value.offer;
    gtotal = as + b - c - d - e;
  }

  getCurentOrder() async {
    SharedPreferences spreferences = await SharedPreferences.getInstance();

    var id = spreferences.getInt("id");
    try {
      allCurentOrderList.value = [];
      isLoading(true);
      await Future.delayed(Duration(seconds: 1));
      Service.getCurentOrder(id).then((values) {
        allCurentOrderList.value = values.orders.toList();
        // ignore: invalid_use_of_protected_member
        if (allCurentOrderList.value.length > 0) {
          curentOrder.value =
              // ignore: invalid_use_of_protected_member
              allCurentOrderList.value[allCurentOrderList.value.length - 1];
        }
        print(allCurentOrderList.length);
      });
    } finally {
      isLoading(false);
    }
  }

  getPopularOrder() async {
    SharedPreferences spreferences = await SharedPreferences.getInstance();

    var id = spreferences.getInt("id");
    var lat = tController.userlat.value;
    var lo = tController.userlong.value;
    try {
      allCurentOrderList.value = [];
      if (lat > 0) {
        isLoading(true);
        await Future.delayed(Duration(seconds: 1));
        Service.getPopularShop(id, lat, lo).then((values) {
          if (!values.isNull) {
            polularShopList.value = values.data.toList();
          }

          // if(polularShopList.value.length>0){
          //   curentOrder.value = polularShopList.value[0];
          // }
          print(polularShopList.length);
        });
      }
    } finally {
      isLoading(false);
    }
  }

  getpointerLocation(String lat, String lng) async {
    double la = double.parse(lng);
    double lg = double.parse(lat);
    print("call api");
    print(la);
    await Future.delayed(Duration(seconds: 1));
    // ignore: unused_local_variable
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordi = new Coordinates(lg, la);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordi);
    // var add = await Geocoder.google(your_API_Key).findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    address.value = first.addressLine;
  }

  getShopAddress(String lat, String lng) async {
    var la = double.parse(lat);
    var lg = double.parse(lng);
    print(la);
    print(lg);

    final coordinates = new Coordinates(la, lg);
    print(lg);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(lg);
    var first = addresses.first;
    address.value = first.addressLine;
    print(address.value);
  }
}
