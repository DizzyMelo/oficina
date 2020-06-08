// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
    PaymentModel({
        this.id,
        this.formaId,
        this.sts,
        this.servicoId,
        this.dataPagamento,
        this.valor,
    });

    String id;
    String formaId;
    String sts;
    String servicoId;
    DateTime dataPagamento;
    String valor;

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        formaId: json["forma_id"],
        sts: json["sts"],
        servicoId: json["servico_id"],
        dataPagamento: DateTime.parse(json["data_pagamento"]),
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "forma_id": formaId,
        "sts": sts,
        "servico_id": servicoId,
        "data_pagamento": dataPagamento.toIso8601String(),
        "valor": valor,
    };
}
