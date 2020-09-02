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
    this.phone,
    this.role,
    this.id,
    this.name,
    this.email,
    this.shop,
    this.cpfcnpj,
    this.v,
    this.userId,
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
  String userId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        photo: json["photo"],
        phone: List<dynamic>.from(json["phone"].map((x) => x)),
        role: json["role"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        shop: json["shop"],
        cpfcnpj: json["cpfcnpj"],
        v: json["__v"],
        userId: json["id"],
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
        "id": userId,
      };
}
