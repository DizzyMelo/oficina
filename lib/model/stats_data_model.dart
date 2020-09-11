// To parse this JSON data, do
//
//     final statsDataModel = statsDataModelFromJson(jsonString);

import 'dart:convert';

StatsDataModel statsDataModelFromJson(String str) =>
    StatsDataModel.fromJson(json.decode(str));

String statsDataModelToJson(StatsDataModel data) => json.encode(data.toJson());

class StatsDataModel {
  StatsDataModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory StatsDataModel.fromJson(Map<String, dynamic> json) => StatsDataModel(
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
    this.stats,
  });

  List<Stat> stats;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
      };
}

class Stat {
  Stat({
    this.id,
    this.total,
    this.counter,
    this.ave,
    this.min,
    this.max,
  });

  String id;
  double total;
  int counter;
  double ave;
  double min;
  double max;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        id: json["_id"],
        total: json["total"],
        counter: json["counter"],
        ave: json["ave"],
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "total": total,
        "counter": counter,
        "ave": ave,
        "min": min,
        "max": max,
      };
}
