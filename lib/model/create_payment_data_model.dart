// To parse this JSON data, do
//
//     final createPaymentDataModel = createPaymentDataModelFromJson(jsonString);

import 'dart:convert';

CreatePaymentDataModel createPaymentDataModelFromJson(String str) =>
    CreatePaymentDataModel.fromJson(json.decode(str));

String createPaymentDataModelToJson(CreatePaymentDataModel data) =>
    json.encode(data.toJson());

class CreatePaymentDataModel {
  CreatePaymentDataModel({
    this.status,
    this.data,
  });

  String status;
  CreatePaymentDataModelData data;

  factory CreatePaymentDataModel.fromJson(Map<String, dynamic> json) =>
      CreatePaymentDataModel(
        status: json["status"],
        data: CreatePaymentDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class CreatePaymentDataModelData {
  CreatePaymentDataModelData({
    this.data,
  });

  DataData data;

  factory CreatePaymentDataModelData.fromJson(Map<String, dynamic> json) =>
      CreatePaymentDataModelData(
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
    this.value,
    this.method,
    this.service,
    this.v,
  });

  DateTime date;
  String id;
  int value;
  String method;
  String service;
  int v;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        date: DateTime.parse(json["date"]),
        id: json["_id"],
        value: json["value"],
        method: json["method"],
        service: json["service"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "_id": id,
        "value": value,
        "method": method,
        "service": service,
        "__v": v,
      };
}
