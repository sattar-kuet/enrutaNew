import 'package:enruta/api/service.dart';
import 'package:enruta/model/addReview.dart';
import 'package:enruta/model/category_model.dart';
import 'package:enruta/model/near_by_place_data.dart';
import 'package:enruta/model/popular_shop.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestController extends GetxController {
  static const String url = 'https://enruta.itscholarbd.com/api/v2/categories';

  // ignore: deprecated_member_use
  var category = List<Category>().obs;
  // ignore: deprecated_member_use
  var nearbyres = List<Datum>().obs;
  // ignore: deprecated_member_use
  var nearbycat = List<Datum>().obs;
  // ignore: deprecated_member_use
  var polularShopList = List<Datums>().obs;
  var sendtime = "".obs;

  var shopid = 0.obs;
  Rx<int> orderCompletedShop;

  final address = ''.obs;
  var userlat = 0.0.obs;
  var userlong = 0.0.obs;
  var locationpermision = false.obs;
  var st = 0.obs;
  RxBool spin = false.obs;
  var isLoading = true.obs;
  var orderiscoming = true.obs;

  @override
  void onInit() {
    super.onInit();
    getmenulist();
    getLocation();
  }

  RxBool filter1 = true.obs;
  RxBool filter2 = true.obs;
  RxBool filter3 = true.obs;
  RxBool filter4 = true.obs;
  RxBool filter5 = true.obs;
  RxBool filter6 = true.obs;
  RxBool filter7 = true.obs;
  RxBool filter8 = true.obs;
  RxBool filter9 = true.obs;

  void getmenulist() async {
    try {
      isLoading(true);
      Service.getcategory().then((values) {
        // todos = values.categories.toList();
        category.value = values.categories.toList();
        // print("category.toList");
        // print(category.toList);
        // print(category.length);
      });
    } finally {
      isLoading(false);
    }
  }

  completeOrder(int shopid) async {
    SharedPreferences spreferences = await SharedPreferences.getInstance();
    spreferences.setInt("OrderCompletedShop", shopid);
    print("Complete Order called");
  }

  addrivew(int shopid, double rating, String comment) async {
    SharedPreferences spreferences = await SharedPreferences.getInstance();
    var id = spreferences.getInt("id");
    var model = new AddReview(
        user_id: id, shop_id: shopid, rating: rating, comment: comment);
    var a = await Service.addorupdateReview(model);
    print(a);
  }

  getPopularShops() async {
    SharedPreferences spreferences = await SharedPreferences.getInstance();
    orderiscoming(true);
    var id = spreferences.getInt("id");
    var lat = userlat.value;
    var lo = userlong.value;
    // try {
    // allCurentOrderList.value = [];
    if (lat > 0) {
      isLoading(true);

      //await Future.delayed(Duration(seconds: 1));
      await Service.getPopularShop(id, lat, lo).then((values) {
        // if(!values.isNull){
        //   polularShopList.value = values.data.toList();
        // }
        st.value = values.status;
        print("$id from getpopularshop ");

        polularShopList.value = values.data.toList();
        //print(polularShopList[1]);

        // if(polularShopList.value.length>0){
        //   curentOrder.value = polularShopList.value[0];
        // }
      }).whenComplete(() => orderiscoming(false));
    }

    // }catch(e){
    //   print(e);
    // }
    // finally {
    //   isLoading(false);
    // }
  }

  void getnearByPlace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var a = prefs.getString("shopid");
    if (a != null) {
      shopid.value = int.parse(a);
    }

    await Future.delayed(Duration(seconds: 1));
    SharedPreferences pre = await SharedPreferences.getInstance();
    int userid = pre.getInt("id") ?? 93;
    print(userid);
    var lat = userlat.value;
    var lo = userlong.value;
    Service.createAlbum(userid, lat, lo).then((values) {
      st.value = values.status;
      nearbyres.value = values.data;

      print("nearby $nearbyres");
      print("Sortin");
      nearbyres.forEach((d) {
        if (d.shopId == shopid.value) {
          sendtime.value = d.time;
          print("XXXX: ${d.time}");
        }
      });
    });
  }

  getLocation() async {
    GetStorage box = GetStorage();
    Coordinates coordinates;
    Position position;
    if (box.read("selectLet") != null) {
      userlat.value = double.parse(box.read("selectLet"));
      userlong.value = double.parse(box.read("selectLng"));
      print(userlat.value);
      print(userlong.value);
      coordinates = new Coordinates(userlat.value, userlong.value);

      print("Got from storage");
    } else {
      var permission = await Geolocator().checkGeolocationPermissionStatus();
      if (permission != GeolocationStatus.denied) {
        locationpermision.value = true;
        position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        userlat.value = position.latitude;
        userlong.value = position.longitude;
        coordinates = new Coordinates(position.latitude, position.longitude);
        print("Got from Onilne");
      } else {}
    }

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    address.value = first.addressLine;
    address(first.addressLine);

    //print(address);
    getnearByPlace();
    getPopularShops();
  }
}
//Popular and nearby issue//

///////////////////*****************************//////////////////////// */
/////////////////////***************************//////////////////////
