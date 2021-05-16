import 'package:get/get.dart';

class Product {
  Product({this.id, this.title, this.subTxt, this.price, this.logo, this.qty});

  int id;
  String title;
  String subTxt;
  int price;
  String logo;
  var qty = 1;
  var pqty = 1.obs;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        subTxt: json["subTxt"],
        price: json["price"],
        logo: json["logo"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subTxt": subTxt,
        "price": price,
        "logo": logo,
        "qty": qty,
      };
}
