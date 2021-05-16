import 'dart:convert';

AllOrderModel allOrderFromJson(String str) =>
    AllOrderModel.fromJson(json.decode(str));

String allOrderToJson(AllOrderModel data) => json.encode(data.toJson());

class AllOrderModel {
  AllOrderModel({
    this.status,
    this.orders,
  });

  int status;
  List<OrderModel> orders;

  factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
        status: json["status"],
        orders: List<OrderModel>.from(
            json["orders"].map((x) => OrderModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class OrderModel {
  OrderModel({
    this.id,
    this.titleTxt,
    this.subTxt,
    this.price,
    this.imagePath,
    this.date,
  });

  int id;
  String titleTxt;
  String subTxt;
  String price;
  String imagePath;
  String date;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        titleTxt: json["titleTxt"],
        subTxt: json["subTxt"],
        price: json["price"],
        imagePath: json["imagePath"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titleTxt": titleTxt,
        "subTxt": subTxt,
        "price": price,
        "imagePath": imagePath,
        "date": date,
      };
}
