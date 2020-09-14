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
    this.dateEnd,
    this.observation,
    this.serviceId,
  });

  DateTime date;
  double value;
  String status;
  bool paid;
  double how;
  double discount;
  int warranty;
  String warrantyUnity;
  String id;
  Client client;
  Client colaborator;
  Car car;
  String shop;
  int v;
  DateTime dateEnd;
  String observation;
  String serviceId;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        date: DateTime.parse(json["date"]),
        value: json["value"].toDouble(),
        status: json["status"],
        paid: json["paid"],
        how: json["how"].toDouble(),
        discount: json["discount"].toDouble(),
        warranty: json["warranty"],
        warrantyUnity: json["warrantyUnity"],
        id: json["_id"],
        client: Client.fromJson(json["client"]),
        colaborator: Client.fromJson(json["colaborator"]),
        car: Car.fromJson(json["car"]),
        shop: json["shop"],
        v: json["__v"],
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        observation: json["observation"] == null ? null : json["observation"],
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
        "date_end": dateEnd == null ? null : dateEnd.toIso8601String(),
        "observation": observation == null ? null : observation,
        "id": serviceId,
      };
}

class Car {
  Car({
    this.plate,
    this.id,
    this.name,
    this.user,
    this.v,
  });

  String plate;
  String id;
  String name;
  String user;
  int v;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        plate: json["plate"],
        id: json["_id"],
        name: json["name"],
        user: json["user"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "plate": plate,
        "_id": id,
        "name": name,
        "user": user,
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
    this.email,
    this.secondaryphone,
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
  String email;
  String secondaryphone;

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
        email: json["email"] == null ? null : json["email"],
        secondaryphone:
            json["secondaryphone"] == null ? null : json["secondaryphone"],
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
        "email": email == null ? null : email,
        "secondaryphone": secondaryphone == null ? null : secondaryphone,
      };
}
