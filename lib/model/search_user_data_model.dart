// To parse this JSON data, do
//
//     final searchUserDataModel = searchUserDataModelFromJson(jsonString);

import 'dart:convert';

SearchUserDataModel searchUserDataModelFromJson(String str) =>
    SearchUserDataModel.fromJson(json.decode(str));

String searchUserDataModelToJson(SearchUserDataModel data) =>
    json.encode(data.toJson());

class SearchUserDataModel {
  SearchUserDataModel({
    this.status,
    this.results,
    this.data,
  });

  String status;
  int results;
  Data data;

  factory SearchUserDataModel.fromJson(Map<String, dynamic> json) =>
      SearchUserDataModel(
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
    this.users,
  });

  List<User> users;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  User({
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
    this.v,
    this.userId,
  });

  String photo;
  String role;
  bool active;
  List<dynamic> token;
  String id;
  String name;
  String email;
  String shop;
  String cpfcnpj;
  String secondaryphone;
  String primaryphone;
  int v;
  String userId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        photo: json["photo"],
        role: json["role"],
        active: json["active"],
        token: List<dynamic>.from(json["token"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        shop: json["shop"],
        cpfcnpj: json["cpfcnpj"],
        secondaryphone: json["secondaryphone"],
        primaryphone: json["primaryphone"],
        v: json["__v"],
        userId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "role": role,
        "active": active,
        "token": List<dynamic>.from(token.map((x) => x)),
        "_id": id,
        "name": name,
        "email": email,
        "shop": shop,
        "cpfcnpj": cpfcnpj,
        "secondaryphone": secondaryphone,
        "primaryphone": primaryphone,
        "__v": v,
        "id": userId,
      };
}
