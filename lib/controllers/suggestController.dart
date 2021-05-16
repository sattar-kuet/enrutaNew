import 'package:enruta/api/service.dart';
import 'package:enruta/controllers/cartController.dart';
import 'package:enruta/model/Product_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestController extends GetxController {
  var shopid = "".obs;
  var suggetItems = List<Product>().obs;
  var isLoading = true.obs;
  final vats = 0.obs;
  final dc = 0.obs;
  @override
  void onInit() {
    getsuggetItems();
    super.onInit();
  }

  void getsuggetItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopid.value = prefs.getString('shopid') ?? "1";

    print(shopid.value);
    try {
      suggetItems.value = [];
      isLoading(true);
      await Future.delayed(Duration(seconds: 1));
      Service.menulist(shopid.value).then((va) {
       if(va != null){
         suggetItems.value = va.products.toList();
         shopid.value = va.shopid.toString();
         vats.value = va.vat.toInt();
         print(
             'shopid is $shopid   vat is $vats   delivery charge is $va.deliveryCharge');

         Get.find<CartController>().vat.value = va.vat.toInt();
         Get.find<CartController>().deliveryCharge.value =
             va.deliveryCharge.toInt();

         dc.value = va.deliveryCharge.toInt();

         print(suggetItems.length);
       }
      });
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  removeitemfromlist(int id) {
    for (var i = 0; i < suggetItems.length; i++) {
      if (suggetItems[i].id == id) {
        suggetItems.removeAt(i);
      }
    }
    print('new suggest list ${suggetItems.length}');
  }

  getiteminfo() async {
    SharedPreferences pr = await SharedPreferences.getInstance();
    vats.value = pr.getInt("vat");
    dc.value = pr.getInt("deliveryCharge");
  }

  addtolist(
    Product item,
  ) {
    print(vats.value);
    Get.find<CartController>()
        .additemtocarts(item, shopid.value, vats.value, dc.value);
  }
}
