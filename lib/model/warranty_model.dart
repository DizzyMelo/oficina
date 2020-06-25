// To parse this JSON data, do
//
//     final warrantyModel = warrantyModelFromJson(jsonString);

import 'dart:convert';

WarrantyModel warrantyModelFromJson(String str) => WarrantyModel.fromJson(json.decode(str));

String warrantyModelToJson(WarrantyModel data) => json.encode(data.toJson());

class WarrantyModel {
    WarrantyModel({
        this.id,
        this.garantia,
        this.selected = false,
        this.loading = false
    });

    String id;
    String garantia;
    bool selected;
    bool loading;

    factory WarrantyModel.fromJson(Map<String, dynamic> json) => WarrantyModel(
        id: json["id"],
        garantia: json["garantia"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "garantia": garantia,
    };
}
