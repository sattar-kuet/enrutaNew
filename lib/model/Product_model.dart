import 'package:get/get.dart';

class Product {
  Product(
      {this.id,
      this.title,
      this.subTxt,
      this.price,
      this.logo,
      this.qty,
      this.sizes,
      this.colors});

  int id;
  String title;
  String subTxt;
  double price;
  String logo;
  List<String> sizes;
  List<String> colors;

  var qty = 1;
  var pqty = 1.obs;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        subTxt: json["subTxt"],
        price: json["price"].toDouble(),
        logo: json["logo"],
        sizes: json["sizes"] != null
            ? List<String>.from(json["sizes"].map((x) => x))
            : null,
        colors: json["colors"] != null
            ? List<String>.from(json["colors"].map((x) => x))
            : null,
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subTxt": subTxt,
        "price": price,
        "logo": logo,
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "qty": qty,
      };
}
