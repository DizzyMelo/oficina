// To parse this JSON data, do
//
//     final reportServiceDataModel = reportServiceDataModelFromJson(jsonString);

import 'dart:convert';

ReportServiceDataModel reportServiceDataModelFromJson(String str) =>
    ReportServiceDataModel.fromJson(json.decode(str));

String reportServiceDataModelToJson(ReportServiceDataModel data) =>
    json.encode(data.toJson());

class ReportServiceDataModel {
  ReportServiceDataModel({
    this.status,
    this.results,
    this.data,
  });

  String status;
  int results;
  Data data;

  factory ReportServiceDataModel.fromJson(Map<String, dynamic> json) =>
      ReportServiceDataModel(
        status: json["status"],
        results: json["results"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "results": results,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.services,
  });

  List<Service> services;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    this.date,
    this.value,
    this.status,
    this.paid,
    this.how,
    this.discount,
    this.warranty,
    this.warrantyUnity,
    this.id,
    this.client,
    this.colaborator,
    this.car,
    this.shop,
    this.v,
    this.serviceId,
  });

  DateTime date;
  double value;
  String status;
  bool paid;
  int how;
  int discount;
  int warranty;
  String warrantyUnity;
  String id;
  Client client;
  Client colaborator;
  Car car;
  String shop;
  int v;
  String serviceId;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        date: DateTime.parse(json["date"]),
        value: json["value"],
        status: json["status"],
        paid: json["paid"],
        how: json["how"],
        discount: json["discount"],
        warranty: json["warranty"],
        warrantyUnity: json["warrantyUnity"],
        id: json["_id"],
        client: Client.fromJson(json["client"]),
        colaborator: Client.fromJson(json["colaborator"]),
        car: Car.fromJson(json["car"]),
        shop: json["shop"],
        v: json["__v"],
        serviceId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "value": value,
        "status": status,
        "paid": paid,
        "how": how,
        "discount": discount,
        "warranty": warranty,
        "warrantyUnity": warrantyUnity,
        "_id": id,
        "client": client.toJson(),
        "colaborator": colaborator.toJson(),
        "car": car.toJson(),
        "shop": shop,
        "__v": v,
        "id": serviceId,
      };
}

class Car {
  Car({
    this.plate,
    this.id,
    this.name,
    this.v,
  });

  String plate;
  String id;
  String name;
  int v;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        plate: json["plate"],
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "plate": plate,
        "_id": id,
        "name": name,
        "__v": v,
      };
}

class Client {
  Client({
    this.photo,
    this.role,
    this.active,
    this.token,
    this.id,
    this.name,
    this.shop,
    this.primaryphone,
    this.v,
    this.cpfcnpj,
    this.clientId,
  });

  String photo;
  String role;
  bool active;
  List<dynamic> token;
  String id;
  String name;
  String shop;
  String primaryphone;
  int v;
  String cpfcnpj;
  String clientId;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        photo: json["photo"],
        role: json["role"],
        active: json["active"],
        token: List<dynamic>.from(json["token"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        shop: json["shop"],
        primaryphone: json["primaryphone"],
        v: json["__v"],
        cpfcnpj: json["cpfcnpj"],
        clientId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "role": role,
        "active": active,
        "token": List<dynamic>.from(token.map((x) => x)),
        "_id": id,
        "name": name,
        "shop": shop,
        "primaryphone": primaryphone,
        "__v": v,
        "cpfcnpj": cpfcnpj,
        "id": clientId,
      };
}
