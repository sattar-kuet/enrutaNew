import 'package:enruta/api/service.dart';
import 'package:enruta/controllers/cartController.dart';
import 'package:enruta/model/Product_model.dart';
import 'package:enruta/model/review_model.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  var menuItems = List<Product>().obs;
  // ignore: deprecated_member_use
  var reviewItems = List<Review>().obs;
  final cartController  = Get.put(CartController());

  var cartList = List<Product>().obs;

  var menuItemsTemp = List<Product>().obs;

  var categoryName = ''.obs;
  var cartLists = List<Product>().obs;
  var qty = 0.obs;

  var st = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
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
         cartLists.value = cartController.cartList.value;
         if(cartController.cartList.value.length>0){
           for(var j=0; j<menuItemsTemp.value.length; j++){
             for (var i = 0; i < cartController.cartList.length; i++) {
               if (menuItemsTemp.value[j].id != 0 && menuItemsTemp.value[j].id == cartController.cartList[i].id) {
                 // cartList.value[i].qty = item.qty;
                 menuItemsTemp.value[j].pqty.value = cartController.cartList[i].qty;
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

  void incrementqty(var id, var positon){
    for(int i =0; i<menuItems.value.length; i++){
      if(menuItems.value[i].id== id){
        menuItems.value[i].qty++;
      }
    }
    // if(menuItems.value.length>0){
    //   menuItems.value[positon].qty++;
    // }
  }

  void diCrement(var id, var positon){
    for(int i =0; i<menuItems.value.length; i++){
      if(menuItems.value[i].id== id){
       if( menuItems.value[i].qty>0){
         menuItems.value[i].qty--;
       }
      }
    }
    // if(menuItems.value.length>0){
    //   menuItems.value[positon].qty++;
    // }
  }

  void getreview(int id) async {
    try {
      reviewItems.value = [];
      isLoading(true);
      await Future.delayed(Duration(seconds: 1));
      Service.getreview(id).then((values) {
        reviewItems.value = values.reviews.toList();
      });
    } finally {
      isLoading(false);
    }
  }

  void addtocart(Product item) {
    cartList.add(item);
  }

  increment(int id) {
    for (var i = 0; i < menuItems.length; i++) {
      if (menuItems[i].id == id) {
        qty.value = menuItems[i].qty++;
      }
    }
  }

  decrement() {
    if (qty > 0) {
      qty--;
    }
  }

  changefavorite(int id, int showpId) async {}
}
