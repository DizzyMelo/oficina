// To parse this JSON data, do
//
//     final getPaymentsDataModel = getPaymentsDataModelFromJson(jsonString);

import 'dart:convert';

GetPaymentsDataModel getPaymentsDataModelFromJson(String str) =>
    GetPaymentsDataModel.fromJson(json.decode(str));

String getPaymentsDataModelToJson(GetPaymentsDataModel data) =>
    json.encode(data.toJson());

class GetPaymentsDataModel {
  GetPaymentsDataModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory GetPaymentsDataModel.fromJson(Map<String, dynamic> json) =>
      GetPaymentsDataModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.payments,
  });

  List<Payment> payments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}

class Payment {
  Payment({
    this.date,
    this.id,
    this.value,
    this.method,
    this.service,
    this.v,
  });

  DateTime date;
  String id;
  double value;
  String method;
  String service;
  int v;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
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
