// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'dart:convert';

CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

class CarModel {
    CarModel({
        this.id,
        this.modelo,
        this.placa,
        this.clienteId,
        this.sts,
    });

    String id;
    String modelo;
    String placa;
    String clienteId;
    String sts;

    factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["id"],
        modelo: json["modelo"],
        placa: json["placa"],
        clienteId: json["cliente_id"],
        sts: json["sts"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "modelo": modelo,
        "placa": placa,
        "cliente_id": clienteId,
        "sts": sts,
    };
}
