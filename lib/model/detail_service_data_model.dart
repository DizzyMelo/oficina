// To parse this JSON data, do
//
//     final detailServiceDataModel = detailServiceDataModelFromJson(jsonString);

import 'dart:convert';

DetailServiceDataModel detailServiceDataModelFromJson(String str) =>
    DetailServiceDataModel.fromJson(json.decode(str));

String detailServiceDataModelToJson(DetailServiceDataModel data) =>
    json.encode(data.toJson());

class DetailServiceDataModel {
  DetailServiceDataModel({
    this.status,
    this.data,
  });

  String status;
  DetailServiceDataModelData data;

  factory DetailServiceDataModel.fromJson(Map<String, dynamic> json) =>
      DetailServiceDataModel(
        status: json["status"],
        data: DetailServiceDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class DetailServiceDataModelData {
  DetailServiceDataModelData({
    this.data,
  });

  DataData data;

  factory DetailServiceDataModelData.fromJson(Map<String, dynamic> json) =>
      DetailServiceDataModelData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataData {
  DataData({
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
    this.v,
    this.dateEnd,
    this.observation,
    this.addedProducts,
    this.dataId,
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
  int v;
  DateTime dateEnd;
  String observation;
  List<AddedProduct> addedProducts;
  String dataId;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        date: DateTime.parse(json["date"]),
        value: json["value"].toDouble(),
        status: json["status"],
        paid: json["paid"],
        how: json["how"].toDouble(),
        discount: json["discount"].toDouble(),
        warranty: json["warranty"],
        warrantyUnity: json["warrantyUnity"],
        id: json["_id"],
        client: Client.fromJson(json["client"]),
        colaborator: json["colaborator"] == null
            ? null
            : Client.fromJson(json["colaborator"]),
        car: Car.fromJson(json["car"]),
        shop: json["shop"],
        v: json["__v"],
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        observation: json["observation"] == null ? null : json["observation"],
        addedProducts: List<AddedProduct>.from(
            json["added_products"].map((x) => AddedProduct.fromJson(x))),
        dataId: json["id"],
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
        "client": client.toJson(),
        "colaborator": colaborator == null ? null : colaborator.toJson(),
        "car": car.toJson(),
        "shop": shop,
        "__v": v,
        "date_end": dateEnd.toIso8601String(),
        "observation": observation,
        "added_products":
            List<dynamic>.from(addedProducts.map((x) => x.toJson())),
        "id": dataId,
      };
}

class AddedProduct {
  AddedProduct({
    this.date,
    this.id,
    this.service,
    this.product,
    this.amount,
    this.totalPrice,
    this.v,
    this.addedProductId,
  });

  DateTime date;
  String id;
  String service;
  Product product;
  int amount;
  int totalPrice;
  int v;
  String addedProductId;

  factory AddedProduct.fromJson(Map<String, dynamic> json) => AddedProduct(
        date: DateTime.parse(json["date"]),
        id: json["_id"],
        service: json["service"],
        product: Product.fromJson(json["product"]),
        amount: json["amount"],
        totalPrice: json["totalPrice"],
        v: json["__v"],
        addedProductId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "_id": id,
        "service": service,
        "product": product.toJson(),
        "amount": amount,
        "totalPrice": totalPrice,
        "__v": v,
        "id": addedProductId,
      };
}

class Product {
  Product({
    this.active,
    this.minimumAmount,
    this.priceBought,
    this.id,
    this.name,
    this.description,
    this.code,
    this.currentAmount,
    this.priceSale,
    this.shop,
    this.v,
  });

  bool active;
  int minimumAmount;
  int priceBought;
  String id;
  String name;
  String description;
  String code;
  int currentAmount;
  int priceSale;
  String shop;
  int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        active: json["active"],
        minimumAmount: json["minimum_amount"],
        priceBought: json["price_bought"],
        id: json["_id"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        code: json["code"] == null ? null : json["code"],
        currentAmount: json["current_amount"],
        priceSale: json["price_sale"],
        shop: json["shop"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "minimum_amount": minimumAmount,
        "price_bought": priceBought,
        "_id": id,
        "name": name,
        "description": description == null ? null : description,
        "code": code == null ? null : code,
        "current_amount": currentAmount,
        "price_sale": priceSale,
        "shop": shop,
        "__v": v,
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
      };
}
