// To parse this JSON data, do
//
//     final editProductDataModel = editProductDataModelFromJson(jsonString);

import 'dart:convert';

EditProductDataModel editProductDataModelFromJson(String str) =>
    EditProductDataModel.fromJson(json.decode(str));

String editProductDataModelToJson(EditProductDataModel data) =>
    json.encode(data.toJson());

class EditProductDataModel {
  EditProductDataModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  EditProductDataModelData data;

  factory EditProductDataModel.fromJson(Map<String, dynamic> json) =>
      EditProductDataModel(
        status: json["status"],
        message: json["message"],
        data: EditProductDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class EditProductDataModelData {
  EditProductDataModelData({
    this.data,
  });

  DataData data;

  factory EditProductDataModelData.fromJson(Map<String, dynamic> json) =>
      EditProductDataModelData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataData {
  DataData({
    this.active,
    this.minimumAmount,
    this.priceBought,
    this.id,
    this.name,
    this.description,
    this.code,
    this.currentAmount,
    this.priceSale,
    this.shop,
    this.v,
  });

  bool active;
  int minimumAmount;
  int priceBought;
  String id;
  String name;
  String description;
  String code;
  int currentAmount;
  int priceSale;
  String shop;
  int v;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        active: json["active"],
        minimumAmount: json["minimum_amount"],
        priceBought: json["price_bought"],
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        code: json["code"],
        currentAmount: json["current_amount"],
        priceSale: json["price_sale"],
        shop: json["shop"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "minimum_amount": minimumAmount,
        "price_bought": priceBought,
        "_id": id,
        "name": name,
        "description": description,
        "code": code,
        "current_amount": currentAmount,
        "price_sale": priceSale,
        "shop": shop,
        "__v": v,
      };
}
