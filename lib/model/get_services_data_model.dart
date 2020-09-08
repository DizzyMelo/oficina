// To parse this JSON data, do
//
//     final getServiceDataModel = getServiceDataModelFromJson(jsonString);

import 'dart:convert';

GetServiceDataModel getServiceDataModelFromJson(String str) =>
    GetServiceDataModel.fromJson(json.decode(str));

String getServiceDataModelToJson(GetServiceDataModel data) =>
    json.encode(data.toJson());

class GetServiceDataModel {
  GetServiceDataModel({
    this.status,
    this.results,
    this.data,
  });

  String status;
  int results;
  Data data;

  factory GetServiceDataModel.fromJson(Map<String, dynamic> json) =>
      GetServiceDataModel(
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
    this.data,
  });

  List<Datum> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        shop: shopValues.map[json["shop"]],
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
        "shop": shopValues.reverse[shop],
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

  Photo photo;
  Role role;
  bool active;
  List<dynamic> token;
  String id;
  String name;
  Shop shop;
  String primaryphone;
  int v;
  String cpfcnpj;
  String clientId;
  String email;
  String secondaryphone;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        photo: photoValues.map[json["photo"]],
        role: roleValues.map[json["role"]],
        active: json["active"],
        token: List<dynamic>.from(json["token"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        shop: shopValues.map[json["shop"]],
        primaryphone: json["primaryphone"],
        v: json["__v"],
        cpfcnpj: json["cpfcnpj"],
        clientId: json["id"],
        email: json["email"] == null ? null : json["email"],
        secondaryphone:
            json["secondaryphone"] == null ? null : json["secondaryphone"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photoValues.reverse[photo],
        "role": roleValues.reverse[role],
        "active": active,
        "token": List<dynamic>.from(token.map((x) => x)),
        "_id": id,
        "name": name,
        "shop": shopValues.reverse[shop],
        "primaryphone": primaryphone,
        "__v": v,
        "cpfcnpj": cpfcnpj,
        "id": clientId,
        "email": email == null ? null : email,
        "secondaryphone": secondaryphone == null ? null : secondaryphone,
      };
}

enum Photo { DEFAULT_JPG }

final photoValues = EnumValues({"default.jpg": Photo.DEFAULT_JPG});

enum Role { CLIENTE, MECANICO }

final roleValues =
    EnumValues({"cliente": Role.CLIENTE, "mecanico": Role.MECANICO});

enum Shop { THE_5_F5501_F9_DC5_E190_B4_FECD9_D7 }

final shopValues = EnumValues(
    {"5f5501f9dc5e190b4fecd9d7": Shop.THE_5_F5501_F9_DC5_E190_B4_FECD9_D7});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
