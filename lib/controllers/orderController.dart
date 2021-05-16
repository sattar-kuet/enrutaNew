import 'package:enruta/api/service.dart';
import 'package:enruta/model/all_order_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  var allOrderList = List<OrderModel>().obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    getAllOrder();
  }

  void getAllOrder() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    var id = pre.getInt("id");
    // int pId = int.parse(id);
    print('pid is $id');
    try {
      allOrderList.value = [];
      isLoading(true);
      await Future.delayed(Duration(seconds: 1));
      Service.getAllOrder(id).then((values) {
        allOrderList.value = values.orders.toList();
        print(allOrderList.length);
      });
    } finally {
      isLoading(false);
    }
  }
}
