// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
    String id;
    String nome;
    String aplicacao;
    String valorPago;
    String valorVenda;
    String qtd;
    String qtdMin;
    String sts;
    String lojaId;
    String codigo;

    ItemModel({
        this.id,
        this.nome,
        this.aplicacao,
        this.valorPago,
        this.valorVenda,
        this.qtd,
        this.qtdMin,
        this.sts,
        this.lojaId,
        this.codigo,
    });

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        nome: json["nome"],
        aplicacao: json["aplicacao"],
        valorPago: json["valor_pago"],
        valorVenda: json["valor_venda"],
        qtd: json["qtd"],
        qtdMin: json["qtd_min"],
        sts: json["sts"],
        lojaId: json["loja_id"],
        codigo: json["codigo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "aplicacao": aplicacao,
        "valor_pago": valorPago,
        "valor_venda": valorVenda,
        "qtd": qtd,
        "qtd_min": qtdMin,
        "sts": sts,
        "loja_id": lojaId,
        "codigo": codigo,
    };
}
