// To parse this JSON data, do
//
//     final paymentFormatModel = paymentFormatModelFromJson(jsonString);

import 'dart:convert';

PaymentFormatModel paymentFormatModelFromJson(String str) => PaymentFormatModel.fromJson(json.decode(str));

String paymentFormatModelToJson(PaymentFormatModel data) => json.encode(data.toJson());

class PaymentFormatModel {
    PaymentFormatModel({
        this.id,
        this.forma,
        this.selected = false
    });

    String id;
    String forma;
    bool selected;

    factory PaymentFormatModel.fromJson(Map<String, dynamic> json) => PaymentFormatModel(
        id: json["id"],
        forma: json["forma"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "forma": forma,
    };
}