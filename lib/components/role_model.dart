// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class RoleModel {
    RoleModel({
        this.id,
        this.funcao,
        this.loja,
        this.sts,
    });

    String id;
    String funcao;
    String loja;
    String sts;

    factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        funcao: json["funcao"],
        loja: json["loja"],
        sts: json["sts"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "funcao": funcao,
        "loja": loja,
        "sts": sts,
    };
}
