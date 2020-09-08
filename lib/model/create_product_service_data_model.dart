// To parse this JSON data, do
//
//     final createProductServiceDataModel = createProductServiceDataModelFromJson(jsonString);

import 'dart:convert';

CreateProductServiceDataModel createProductServiceDataModelFromJson(
        String str) =>
    CreateProductServiceDataModel.fromJson(json.decode(str));

String createProductServiceDataModelToJson(
        CreateProductServiceDataModel data) =>
    json.encode(data.toJson());

class CreateProductServiceDataModel {
  CreateProductServiceDataModel({
    this.status,
    this.data,
  });

  String status;
  CreateProductServiceDataModelData data;

  factory CreateProductServiceDataModel.fromJson(Map<String, dynamic> json) =>
      CreateProductServiceDataModel(
        status: json["status"],
        data: CreateProductServiceDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class CreateProductServiceDataModelData {
  CreateProductServiceDataModelData({
    this.data,
  });

  DataData data;

  factory CreateProductServiceDataModelData.fromJson(
          Map<String, dynamic> json) =>
      CreateProductServiceDataModelData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataData {
  DataData({
    this.date,
    this.id,
    this.service,
    this.product,
    this.amount,
    this.totalPrice,
    this.v,
    this.dataId,
  });

  DateTime date;
  String id;
  String service;
  String product;
  int amount;
  int totalPrice;
  int v;
  String dataId;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        date: DateTime.parse(json["date"]),
        id: json["_id"],
        service: json["service"],
        product: json["product"],
        amount: json["amount"],
        totalPrice: json["totalPrice"],
        v: json["__v"],
        dataId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "_id": id,
        "service": service,
        "product": product,
        "amount": amount,
        "totalPrice": totalPrice,
        "__v": v,
        "id": dataId,
      };
}
