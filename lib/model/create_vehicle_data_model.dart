// To parse this JSON data, do
//
//     final createVehicleDataModel = createVehicleDataModelFromJson(jsonString);

import 'dart:convert';

CreateVehicleDataModel createVehicleDataModelFromJson(String str) =>
    CreateVehicleDataModel.fromJson(json.decode(str));

String createVehicleDataModelToJson(CreateVehicleDataModel data) =>
    json.encode(data.toJson());

class CreateVehicleDataModel {
  CreateVehicleDataModel({
    this.status,
    this.data,
  });

  String status;
  CreateVehicleDataModelData data;

  factory CreateVehicleDataModel.fromJson(Map<String, dynamic> json) =>
      CreateVehicleDataModel(
        status: json["status"],
        data: CreateVehicleDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class CreateVehicleDataModelData {
  CreateVehicleDataModelData({
    this.data,
  });

  DataData data;

  factory CreateVehicleDataModelData.fromJson(Map<String, dynamic> json) =>
      CreateVehicleDataModelData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataData {
  DataData({
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

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
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
