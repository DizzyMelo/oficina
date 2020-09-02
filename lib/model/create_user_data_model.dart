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
    this.phone,
    this.role,
    this.id,
    this.name,
    this.email,
    this.password,
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
  String password;
  String shop;
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
        password: json["password"],
        shop: json["shop"],
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
        "password": password,
        "shop": shop,
        "cpfcnpj": cpfcnpj,
        "__v": v,
        "id": dataId,
      };
}
