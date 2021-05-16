import 'dart:convert';

import 'Product_model.dart';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  MenuModel({
    this.status,
    this.shopid,
    this.vat,
    this.deliveryCharge,
    this.shopCategory,
    this.categoryName,
    this.products,
  });

  int status;
  String shopid;
  int vat;
  int deliveryCharge;
  int shopCategory;
  String categoryName;
  List<Product> products ;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        status: json["status"],
        shopid: json["shopid"],
        vat: json["vat"],
        deliveryCharge: json["deliveryCharge"],
        shopCategory: json["shopCategory"],
        categoryName: json["categoryName"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "shopid": shopid,
        "vat": vat,
        "deliveryCharge": deliveryCharge,
        "shopCategory": shopCategory,
        "categoryName": categoryName,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
