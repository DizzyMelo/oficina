// To parse this JSON data, do
//
//     final searchProductDataModel = searchProductDataModelFromJson(jsonString);

import 'dart:convert';

SearchProductDataModel searchProductDataModelFromJson(String str) =>
    SearchProductDataModel.fromJson(json.decode(str));

String searchProductDataModelToJson(SearchProductDataModel data) =>
    json.encode(data.toJson());

class SearchProductDataModel {
  SearchProductDataModel({
    this.status,
    this.results,
    this.data,
  });

  String status;
  int results;
  Data data;

  factory SearchProductDataModel.fromJson(Map<String, dynamic> json) =>
      SearchProductDataModel(
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
    this.active,
    this.minimumAmount,
    this.priceBought,
    this.id,
    this.name,
    this.code,
    this.currentAmount,
    this.priceSale,
    this.store,
    this.description,
    this.shop,
  });

  bool active;
  int minimumAmount;
  double priceBought;
  String id;
  String name;
  String code;
  int currentAmount;
  double priceSale;
  String store;
  String description;
  String shop;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        active: json["active"],
        minimumAmount: json["minimum_amount"],
        priceBought: json["price_bought"],
        id: json["_id"],
        name: json["name"],
        code: json["code"],
        currentAmount: json["current_amount"],
        priceSale: json["price_sale"],
        store: json["store"] == null ? null : json["store"],
        description: json["description"] == null ? null : json["description"],
        shop: json["shop"] == null ? null : json["shop"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "minimum_amount": minimumAmount,
        "price_bought": priceBought,
        "_id": id,
        "name": name,
        "code": code,
        "current_amount": currentAmount,
        "price_sale": priceSale,
        "store": store == null ? null : store,
        "description": description == null ? null : description,
        "shop": shop == null ? null : shop,
      };
}
