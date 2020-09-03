// To parse this JSON data, do
//
//     final getUserDataModel = getUserDataModelFromJson(jsonString);

import 'dart:convert';

GetUserDataModel getUserDataModelFromJson(String str) =>
    GetUserDataModel.fromJson(json.decode(str));

String getUserDataModelToJson(GetUserDataModel data) =>
    json.encode(data.toJson());

class GetUserDataModel {
  GetUserDataModel({
    this.status,
    this.data,
  });

  String status;
  GetUserDataModelData data;

  factory GetUserDataModel.fromJson(Map<String, dynamic> json) =>
      GetUserDataModel(
        status: json["status"],
        data: GetUserDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class GetUserDataModelData {
  GetUserDataModelData({
    this.data,
  });

  DataData data;

  factory GetUserDataModelData.fromJson(Map<String, dynamic> json) =>
      GetUserDataModelData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataData {
  DataData({
    this.photo,
    this.phone,
    this.role,
    this.id,
    this.name,
    this.email,
    this.shop,
    this.cpfcnpj,
    this.v,
    this.dataId,
  });

  String photo;
  List<dynamic> phone;
  String role;
  String id;
  String name;
  String email;
  Shop shop;
  String cpfcnpj;
  int v;
  String dataId;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        photo: json["photo"],
        phone: List<dynamic>.from(json["phone"].map((x) => x)),
        role: json["role"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        shop: Shop.fromJson(json["shop"]),
        cpfcnpj: json["cpfcnpj"],
        v: json["__v"],
        dataId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "role": role,
        "_id": id,
        "name": name,
        "email": email,
        "shop": shop.toJson(),
        "cpfcnpj": cpfcnpj,
        "__v": v,
        "id": dataId,
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
