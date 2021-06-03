import 'package:enruta/api/service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var position = 0.obs;
  var sizeSelect = 0.obs;
  var colorSelect = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  changeIndex(int index) {
    print(index);

    position.value = index;

    update();
  }

  void sendfavorit(var shop, var status) async {
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences pre = await SharedPreferences.getInstance();
    print("0");
    var id = pre.getInt("id") ?? pre.getString("id");
    print("1");
    //  var shop = pre.getString('shopid');
    print('status $status');

    Service.setToggleFavorite(id, shop, status).then((values) {
      var value = values;
      // datum.value = values.data;
      print('values===${value.statusCode}');
    });
  }
}
