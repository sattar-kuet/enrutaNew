import 'dart:convert';

SendOrderModel sendOrderModelFromJson(String str) =>
    SendOrderModel.fromJson(json.decode(str));

String sendOrderModelToJson(SendOrderModel data) => json.encode(data.toJson());

class SendOrderModel {
  SendOrderModel({
    this.userId,
    this.addressId,
    this.tax,
    this.deliveryCharge,
    this.coupon,
    this.voucher,
    this.offer,
    this.shopCategory,
    this.paymentOption,
    this.lng,
    this.lat,
    this.items,
  });

  int userId;
  int addressId;
  double tax;
  double deliveryCharge;
  double coupon;
  int voucher;
  int offer;
  String shopCategory;
  String paymentOption;
  String lng;
  String lat;
  List<Item> items;

  factory SendOrderModel.fromJson(Map<String, dynamic> json) => SendOrderModel(
        userId: json["user_id"],
        addressId: json["address_id"],
        tax: json["tax"].toDouble(),
        deliveryCharge: json["delivery_charge"].toDouble(),
        coupon: json["coupon"],
        voucher: json["voucher"],
        offer: json["offer"],
        shopCategory: json["shop_category"],
        paymentOption: json["payment_option"],
        lng: json["lng"],
        lat: json["lat"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "address_id": addressId,
        "tax": tax,
        "delivery_charge": deliveryCharge,
        "coupon": coupon,
        "voucher": voucher,
        "offer": offer,
        "shop_category": shopCategory,
        "payment_option": paymentOption,
        "lng": lng,
        "lat": lat,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.productId,
    this.price,
    this.qty,
  });

  int productId;
  double price;
  int qty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["product_id"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "price": price,
        "qty": qty,
      };
}
