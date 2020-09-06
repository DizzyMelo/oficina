// To parse this JSON data, do
//
//     final createUserDataModel = createUserDataModelFromJson(jsonString);

import 'dart:convert';

CreateUserDataModel createUserDataModelFromJson(String str) =>
    CreateUserDataModel.fromJson(json.decode(str));

String createUserDataModelToJson(CreateUserDataModel data) =>
    json.encode(data.toJson());

class CreateUserDataModel {
  CreateUserDataModel({
    this.status,
    this.data,
  });

  String status;
  CreateUserDataModelData data;

  factory CreateUserDataModel.fromJson(Map<String, dynamic> json) =>
      CreateUserDataModel(
        status: json["status"],
        data: CreateUserDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class CreateUserDataModelData {
  CreateUserDataModelData({
    this.data,
  });

  DataData data;

  factory CreateUserDataModelData.fromJson(Map<String, dynamic> json) =>
      CreateUserDataModelData(
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
    this.password,
    this.shop,
    this.cpfcnpj,
    this.secondaryphone,
    this.primaryphone,
    this.v,
    this.dataId,
  });

  String photo;
  String role;
  bool active;
  List<dynamic> token;
  String id;
  String name;
  String email;
  String password;
  String shop;
  String cpfcnpj;
  String secondaryphone;
  String primaryphone;
  int v;
  String dataId;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        photo: json["photo"],
        role: json["role"],
        active: json["active"],
        token: List<dynamic>.from(json["token"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        shop: json["shop"],
        cpfcnpj: json["cpfcnpj"],
        secondaryphone: json["secondaryphone"],
        primaryphone: json["primaryphone"],
        v: json["__v"],
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
        "password": password,
        "shop": shop,
        "cpfcnpj": cpfcnpj,
        "secondaryphone": secondaryphone,
        "primaryphone": primaryphone,
        "__v": v,
        "id": dataId,
      };
}
