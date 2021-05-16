import 'dart:convert';

VoucherModel voucherModelFromJson(String str) =>
    VoucherModel.fromJson(json.decode(str));

String voucherModelToJson(VoucherModel data) => json.encode(data.toJson());

class VoucherModel {
  VoucherModel({
    this.status,
    this.voucher,
  });

  int status;
  Voucher voucher;

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
        status: json["status"],
        voucher: Voucher.fromJson(json["voucher"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "voucher": voucher.toJson(),
      };
}

class Voucher {
  Voucher({
    this.id,
    this.userId,
    this.code,
    this.status,
    this.validity,
    this.createdAt,
    this.updatedAt,
    this.discount,
    this.minOrder,
    this.title,
  });

  int id;
  int userId;
  String code;
  int status;
  DateTime validity;
  DateTime createdAt;
  DateTime updatedAt;
  int discount;
  int minOrder;
  String title;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        id: json["id"],
        userId: json["user_id"],
        code: json["code"],
        status: json["status"],
        validity: DateTime.parse(json["validity"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        discount: json["discount"],
        minOrder: json["min_order"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "code": code,
        "status": status,
        "validity": validity.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "discount": discount,
        "min_order": minOrder,
        "title": title,
      };
}
