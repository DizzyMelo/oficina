// To parse this JSON data, do
//
//     final createProductDataModel = createProductDataModelFromJson(jsonString);

import 'dart:convert';

CreateProductDataModel createProductDataModelFromJson(String str) =>
    CreateProductDataModel.fromJson(json.decode(str));

String createProductDataModelToJson(CreateProductDataModel data) =>
    json.encode(data.toJson());

class CreateProductDataModel {
  CreateProductDataModel({
    this.status,
    this.data,
  });

  String status;
  CreateProductDataModelData data;

  factory CreateProductDataModel.fromJson(Map<String, dynamic> json) =>
      CreateProductDataModel(
        status: json["status"],
        data: CreateProductDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class CreateProductDataModelData {
  CreateProductDataModelData({
    this.data,
  });

  DataData data;

  factory CreateProductDataModelData.fromJson(Map<String, dynamic> json) =>
      CreateProductDataModelData(
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
