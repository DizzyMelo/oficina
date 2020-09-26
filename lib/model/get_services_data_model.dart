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
    this.discount,
    this.warranty,
    this.warrantyUnity,
    this.id,
    this.client,
    this.colaborator,
    this.car,
    this.shop,
    this.dateEnd,
    this.observation,
    this.datumId,
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
  DateTime dateEnd;
  String observation;
  String datumId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: DateTime.parse(json["date"]),
        value: json["value"].toDouble(),
        status: json["status"],
        paid: json["paid"],
        how: json["how"].toDouble(),
        discount: json["discount"].toDouble(),
        warranty: json["warranty"],
        warrantyUnity: json["warrantyUnity"],
        id: json["_id"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        colaborator: json["colaborator"] == null
            ? null
            : Client.fromJson(json["colaborator"]),
        car: json["car"] == null ? null : Car.fromJson(json["car"]),
        shop: json["shop"],
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        observation: json["observation"] == null ? null : json["observation"],
        datumId: json["id"],
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
        "client": client == null ? null : client.toJson(),
        "colaborator": colaborator == null ? null : colaborator.toJson(),
        "car": car == null ? null : car.toJson(),
        "shop": shop,
        "date_end": dateEnd == null ? null : dateEnd.toIso8601String(),
        "observation": observation == null ? null : observation,
        "id": datumId,
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
