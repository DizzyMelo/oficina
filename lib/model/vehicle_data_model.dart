// To parse this JSON data, do
//
//     final vehicleDataModel = vehicleDataModelFromJson(jsonString);

import 'dart:convert';

VehicleDataModel vehicleDataModelFromJson(String str) =>
    VehicleDataModel.fromJson(json.decode(str));

String vehicleDataModelToJson(VehicleDataModel data) =>
    json.encode(data.toJson());

class VehicleDataModel {
  VehicleDataModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory VehicleDataModel.fromJson(Map<String, dynamic> json) =>
      VehicleDataModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.cars,
  });

  List<Car> cars;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cars: List<Car>.from(json["cars"].map((x) => Car.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cars": List<dynamic>.from(cars.map((x) => x.toJson())),
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
