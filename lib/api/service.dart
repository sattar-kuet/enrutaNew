import 'dart:convert';

import 'package:enruta/controllers/textController.dart';
import 'package:enruta/model/Response.dart';
import 'package:enruta/model/all_order_model.dart';
import 'package:enruta/model/menu_model_data.dart';
import 'package:enruta/model/near_by_place_data.dart';
import 'package:enruta/model/popular_shop.dart';
import 'package:enruta/model/review_model.dart';
import 'package:enruta/model/sendOrder.dart';
import 'package:enruta/screen/orerder/orderDetailsModel.dart';
import 'package:enruta/screen/promotion/offerModel.dart';
import 'package:enruta/screen/voucher/voucher_model.dart';
import 'package:get/get.dart' as g;
import 'package:http/http.dart' as http;

class Service {
  static const String url = 'http://enruta.itscholarbd.com/api/v2/categories';

  static const String urls = 'http://enruta.itscholarbd.com/api/v2/nearByShop';

  static const String getAllorderUrl =
      'http://enruta.itscholarbd.com/api/v2/myOrder';

  static const String getCurentOrderUrl =
      'http://enruta.itscholarbd.com/api/v2/myCurrentOrder';

  static const String getPopularShopUrl =
      'http://enruta.itscholarbd.com/api/v2/nearByPopularShop';

  static const String placeOrderurls =
      'http://enruta.itscholarbd.com/api/v2/placeOrder';
  static const String us =
      'http://enruta.itscholarbd.com/api/v2/getProductByShopId';
  static const String baseUrl = 'http://enruta.itscholarbd.com/api/v2/';

  static const String base_url = 'http://enruta.itscholarbd.com';

  static const String toggleFavorite =
      'http://enruta.itscholarbd.com/api/v2/toggleFavourite';

  static const String getOffersUrl =
      'http://enruta.itscholarbd.com/api/v2/getOffers';

  static const String getOrderDetailsApi =
      'http://enruta.itscholarbd.com/api/v2/getOrderByOrderId';

  static const String getVoucherUrl =
      'http://enruta.itscholarbd.com/api/v2/getVoucherByUserId';

  static Future<Respons> getcategory() async {
    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      if (200 == response.statusCode) {
        final Respons respons = responsFromJson(response.body);
        return respons;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // ignore: missing_return
  static Future<MenuModel> menulist(var x) async {
    print("menu item id $x");
    if (x != null) {
      try {
        // print(uri);

        // final response = await http.get(uri, headers: headers);

        final response = await http.post(
          "http://enruta.itscholarbd.com/api/v2/getProductByShopId",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'shop_id': x.toString(),
          }),
        );

        if (response.statusCode == 200) {
          final MenuModel model = menuModelFromJson(response.body);
          // print(model.products.toList());
          //print(response.body);
          return model;
        } else {
          print("get menu api eerror");
          return null;
        }
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  // static Future<MenuModel> getMenuList(var x) async {
  //   try {
  //     // print(x);
  //     var uri = Uri.parse(base_url);
  //     uri = uri.replace(queryParameters: <String, String>{'shop_id': '2'});

  //     final response = await http.get(
  //       uri,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final MenuModel model = menuModelFromJson(response.body);
  //       // print(model.products.toList());

  //       return model;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  static Future<NearByPlace> getNearByPlace(
      int userid, var lat, var long) async {
    String lats = lat.toString();
    String lon = long.toString();
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': "1",
          'lat': lats,
          'lng': lon,
        }),
      );
      if (response.statusCode == 200) {
        return NearByPlace.fromJson(jsonDecode(response.body));
      } else {
        print("NULLSSSSS");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<OfferModel> getAllOffers() async {
    try {
      final response = await http.post(
        getOffersUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{}),
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return OfferModel.fromJson(jsonDecode(response.body));
      } else {
        print("data null");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<OrderDetailsModel> getOrderDetails(int id) async {
    print("order id : $id");
    try {
      final response = await http.post(
        getOrderDetailsApi,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"id": '$id'}),
      );
      if (response.statusCode == 200) {
        print(response.body);
        return OrderDetailsModel.fromJson(jsonDecode(response.body));
      } else {
        print("data null");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<CuponModel> getCuppons(
      // ignore: non_constant_identifier_names
      String shop_id,
      // ignore: non_constant_identifier_names
      String user_id,
      String code) async {
    try {
      final response = await http.post(
        baseUrl + "applyCode",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "shop_id": '$shop_id',
          "user_id": '$user_id',
          "code": '$code'
        }),
      );
      if (response.statusCode == 200) {
        return CuponModel.fromJson(response.body);
      } else {
        print("data null");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<VoucherModel> getAllVoucher(var id) async {
    try {
      final response = await http.post(
        getVoucherUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"user_id": '$id'}),
      );
      if (response.statusCode == 200) {
        return VoucherModel.fromJson(jsonDecode(response.body));
      } else {
        print("data null");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<ReviewModel> getreview(int id) async {
    try {
      var url = baseUrl + "getReviews";
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'shop_id': id.toString(),
        }),
      );
      print("review body ${response.body}");
      if (response.statusCode == 200) {
        return ReviewModel.fromJson(jsonDecode(response.body));
      } else {
        print("riview api status eror");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<NearByPlace> createAlbum(int id, var lat, var lo) async {
    // String json = '{"user_id": $id, "lat": $lat, "lng": $lo}';
    String json = '{"user_id": $id, "lat": $lat, "lng": $lo}';

    final response = await http.post(urls,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);

    if (response.statusCode == 200) {
      print('SUCCESSFUL: ');

      return NearByPlace.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

  static Future<AllOrderModel> getAllOrder(int id) async {
    String json = '{"user_id": $id}';

    final response = await http.post(getAllorderUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);

    if (response.statusCode == 200) {
      return AllOrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get order List.');
    }
  }

  static Future<AllOrderModel> getCurentOrder(int userId) async {
    String json = '{"user_id": $userId}';

    final response = await http.post(getCurentOrderUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);

    if (response.statusCode == 200) {
      return AllOrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get order List.');
    }
  }

  static Future<PopularShop> getPopularShop(var userId, var lat, var lo) async {
    g.Get.put(TestController());
    print("Get popular whenComplete");
    final tController = g.Get.find<TestController>();
    String json = '{"user_id": $userId, "lat": $lat, "lng": $lo}';
    tController.spin.value = true;
    print("User id $userId");

    final response = await http.post(getPopularShopUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);

    //print(response.body);
    print("${response.statusCode} response status");

    if (response.statusCode == 200) {
      tController.spin.value = false;

      var p = PopularShop.fromJson(jsonDecode(response.body));
      print(p);
      return p;
    } else {
      throw Exception('Failed to get order List.');
    }
  }

  static Future<http.Response> sendorder(SendOrderModel order) async {
    var jsonData = order.toJson();
    var a = json.encode(order);
    print("to json");
    print(jsonData);
    print(a);

    final response = await http.post(placeOrderurls,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: a);

    if (response.statusCode == 200) {
      return response;
    } else {
      print(response);
      print(Exception());
      throw Exception(response.statusCode);

      // throw Exception('Order submint field');
    }
  }

  static Future<http.Response> setToggleFavorite(
      var userid, var shop, var status) async {
    print('settoggele favorite in $userid   $shop  $status');

    final response = await http.post(toggleFavorite,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "user_id": userid.toString(),
          "shop_id": shop.toString(),
          "status": status
        }));

    if (response.statusCode == 200) {
      print('ADD TO FAVOURITE');
      return response;
    } else {
      throw Exception('Order submint field');
    }
  }
}
