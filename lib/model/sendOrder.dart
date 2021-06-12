import 'dart:convert';

SendOrderModel sendOrderModelFromJson(String str) =>
    SendOrderModel.fromJson(json.decode(str));

String sendOrderModelToJson(SendOrderModel data) => json.encode(data.toJson());

class SendOrderModel {
  SendOrderModel(
      {this.userId,
      this.delevery_address,
      this.tax,
      this.deliveryCharge,
      this.coupon,
      this.voucher,
      this.offer,
      this.shop_category,
      this.paymentOption,
      this.lng,
      this.lat,
      this.items,
      this.shop_name,
      this.delevery_time_in_minutes});

  int userId;
  String delevery_address;
  double tax;
  double deliveryCharge;
  double coupon;
  int voucher;
  int offer;
  String shop_category;
  String paymentOption;
  String shop_name;
  int delevery_time_in_minutes;
  String lng;
  String lat;
  List<Item> items;

  factory SendOrderModel.fromJson(Map<String, dynamic> json) => SendOrderModel(
        userId: json["user_id"],
        delevery_address: json["delevery_address"],
        tax: json["tax"].toDouble(),
        deliveryCharge: json["delivery_charge"].toDouble(),
        coupon: json["coupon"],
        voucher: json["voucher"],
        offer: json["offer"],
        shop_name: json["shop_name"],
        delevery_time_in_minutes: json["delevery_time_in_minutes"],
        shop_category: json["shop_category"],
        paymentOption: json["payment_option"],
        lng: json["lng"],
        lat: json["lat"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "delevery_address": delevery_address,
        "tax": tax,
        "delivery_charge": deliveryCharge,
        "coupon": coupon,
        "voucher": voucher,
        "offer": offer,
        "shop_name": shop_name,
        "delevery_time_in_minutes": delevery_time_in_minutes,
        "shop_category": shop_category,
        "payment_option": paymentOption,
        "lng": lng,
        "lat": lat,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({this.productId, this.price, this.qty, this.color, this.size});

  int productId;
  double price;
  int qty;
  String color = "";
  String size = "";

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      productId: json["product_id"],
      price: json["price"],
      qty: json["qty"],
      size: json["size"],
      color: json["color"]);

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "price": price,
        "qty": qty,
        "size": size,
        "color": color
      };
}
