import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/controllers/textController.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:enruta/model/near_by_place_data.dart';
import 'package:enruta/view/item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFavorite extends StatelessWidget {
  // List<VoucherListData> voucherList = VoucherListData.voucherList;
  //List<ItemListData> itemList = ItemListData.itemList;

  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  final tController = Get.put(TestController());
  RxList<Datum> itemList = List<Datum>().obs;

  @override
  Widget build(BuildContext context) {
    if (itemList.isEmpty == true) {
      tController.getnearByPlace();
      // itemList.refresh();
      tController.datum.forEach((u) {
        if (u.favorite == true) {
          print('loop = = $u');
          itemList.add(u);
        }
      });
    } else {
      //  tController.getPopularOrder();
      //itemList.refresh();
      itemList.clear();
      tController.datum.forEach((u) {
        if (u.favorite == true) {
          print('loop = = $u');
          itemList.add(u);
        }
      });
    }
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          leading: IconButton(
            onPressed: () {
              Get.back();
              // Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                  Color(Helper.getHexToInt("#11C7A1")),
                  // Colors.green[600],
                  Color(Helper.getHexToInt("#11E4A1"))
                ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(text('my_favorite'),
              style: TextStyle(
                  fontFamily: 'Poppinsm', fontSize: 18.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: Container(
            color: cardbackgroundColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(children: [
              restaurant(text('restaurant'), context),
              // restaurant(text('retails')),
              // restaurant(text('liquor')),
              // restaurant(text('pharmacies')),
              // Container(
              //     margin: EdgeInsets.only(top: 5),
              //     child: Column(children: [
              //       Text("Restaurant"),
              //     ]))
            ])));
  }

  Widget restaurant(var title, context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        margin: EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 0),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
        child: Column(
          children: [
            Container(
                height: 40,
                width: Get.width,
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: "Poppinsr",
                      fontSize: 14,
                      color: Color(Helper.getHexToInt("#22242A"))),
                )),
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.9 * 0.8,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: itemList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ItemListView(
                        itemData: itemList[index],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
