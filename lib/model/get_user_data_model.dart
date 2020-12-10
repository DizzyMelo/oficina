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
    this.role,
    this.active,
    this.token,
    this.id,
    this.name,
    this.email,
    this.shop,
    this.cpfcnpj,
    this.secondaryphone,
    this.primaryphone,
    this.dataId,
  });

  String photo;
  String role;
  bool active;
  List<dynamic> token;
  String id;
  String name;
  String email;
  Shop shop;
  String cpfcnpj;
  String secondaryphone;
  String primaryphone;
  String dataId;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        photo: json["photo"],
        role: json["role"],
        active: json["active"],
        token: List<dynamic>.from(json["token"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        shop: Shop.fromJson(json["shop"]),
        cpfcnpj: json["cpfcnpj"],
        secondaryphone: json["secondaryphone"],
        primaryphone: json["primaryphone"],
        dataId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "role": role,
        "active": active,
        "token": List<dynamic>.from(token.map((x) => x)),
        "_id": id,
        "name": name,
        "email": email,
        "shop": shop.toJson(),
        "cpfcnpj": cpfcnpj,
        "secondaryphone": secondaryphone,
        "primaryphone": primaryphone,
        "id": dataId,
      };
}

class Shop {
  Shop({
    this.id,
    this.name,
    this.email,
    this.address,
    this.primaryphone,
    this.secondaryphone,
    this.v,
  });

  String id;
  String name;
  String email;
  String address;
  String primaryphone;
  String secondaryphone;
  int v;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        primaryphone: json["primaryphone"],
        secondaryphone: json["secondaryphone"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "address": address,
        "primaryphone": primaryphone,
        "secondaryphone": secondaryphone,
        "__v": v,
      };
}
