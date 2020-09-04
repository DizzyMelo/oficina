// To parse this JSON data, do
//
//     final createServiceDataModel = createServiceDataModelFromJson(jsonString);

import 'dart:convert';

CreateServiceDataModel createServiceDataModelFromJson(String str) =>
    CreateServiceDataModel.fromJson(json.decode(str));

String createServiceDataModelToJson(CreateServiceDataModel data) =>
    json.encode(data.toJson());

class CreateServiceDataModel {
  CreateServiceDataModel({
    this.status,
    this.data,
  });

  String status;
  CreateServiceDataModelData data;

  factory CreateServiceDataModel.fromJson(Map<String, dynamic> json) =>
      CreateServiceDataModel(
        status: json["status"],
        data: CreateServiceDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class CreateServiceDataModelData {
  CreateServiceDataModelData({
    this.data,
  });

  DataData data;

  factory CreateServiceDataModelData.fromJson(Map<String, dynamic> json) =>
      CreateServiceDataModelData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataData {
  DataData({
    this.date,
    this.value,
    this.status,
    this.paid,
    this.how,
    this.warranty,
    this.warrantyUnity,
    this.id,
    this.client,
    this.colaborator,
    this.car,
    this.shop,
    this.v,
  });

  DateTime date;
  int value;
  String status;
  bool paid;
  int how;
  int warranty;
  String warrantyUnity;
  String id;
  Client client;
  Client colaborator;
  Car car;
  Shop shop;
  int v;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        date: DateTime.parse(json["date"]),
        value: json["value"],
        status: json["status"],
        paid: json["paid"],
        how: json["how"],
        warranty: json["warranty"],
        warrantyUnity: json["warrantyUnity"],
        id: json["_id"],
        client: Client.fromJson(json["client"]),
        colaborator: Client.fromJson(json["colaborator"]),
        car: Car.fromJson(json["car"]),
        shop: Shop.fromJson(json["shop"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "value": value,
        "status": status,
        "paid": paid,
        "how": how,
        "warranty": warranty,
        "warrantyUnity": warrantyUnity,
        "_id": id,
        "client": client.toJson(),
        "colaborator": colaborator.toJson(),
        "car": car.toJson(),
        "shop": shop.toJson(),
        "__v": v,
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
    this.phone,
    this.role,
    this.id,
    this.name,
    this.email,
    this.shop,
    this.cpfcnpj,
    this.v,
    this.clientId,
  });

  String photo;
  List<dynamic> phone;
  String role;
  String id;
  String name;
  String email;
  String shop;
  String cpfcnpj;
  int v;
  String clientId;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        photo: json["photo"],
        phone: List<dynamic>.from(json["phone"].map((x) => x)),
        role: json["role"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        shop: json["shop"],
        cpfcnpj: json["cpfcnpj"],
        v: json["__v"],
        clientId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "role": role,
        "_id": id,
        "name": name,
        "email": email,
        "shop": shop,
        "cpfcnpj": cpfcnpj,
        "__v": v,
        "id": clientId,
      };
}

class Shop {
  Shop({
    this.phones,
    this.id,
    this.name,
    this.email,
    this.address,
    this.v,
  });

  List<dynamic> phones;
  String id;
  String name;
  String email;
  String address;
  int v;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        phones: List<dynamic>.from(json["phones"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "phones": List<dynamic>.from(phones.map((x) => x)),
        "_id": id,
        "name": name,
        "email": email,
        "address": address,
        "__v": v,
      };
}
