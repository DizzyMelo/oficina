// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromJson(String str) => ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
    String idServico;
    String dataInicio;
    String dataFinal;
    String valor;
    String mdo;
    String clienteId;
    String nomeCliente;
    String telefone1;
    String telefone2;
    String garantiaId;
    String garantia;
    String carroId;
    String modelo;
    String placa;
    String stsId;
    String sts;
    String colaboradorId;
    String nomeColaborador;
    String desconto;

    ServiceModel({
        this.idServico,
        this.dataInicio,
        this.dataFinal,
        this.valor,
        this.mdo,
        this.clienteId,
        this.nomeCliente,
        this.telefone1,
        this.telefone2,
        this.garantiaId,
        this.garantia,
        this.carroId,
        this.modelo,
        this.placa,
        this.stsId,
        this.sts,
        this.colaboradorId,
        this.nomeColaborador,
        this.desconto,
    });

    factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        idServico: json["idServico"],
        dataInicio: json["data_inicio"],
        dataFinal: json["data_final"],
        valor: json["valor"],
        mdo: json["mdo"],
        clienteId: json["cliente_id"],
        nomeCliente: json["nomeCliente"],
        telefone1: json["telefone1"],
        telefone2: json["telefone2"],
        garantiaId: json["garantia_id"],
        garantia: json["garantia"],
        carroId: json["carro_id"],
        modelo: json["modelo"],
        placa: json["placa"],
        stsId: json["sts_id"],
        sts: json["sts"],
        colaboradorId: json["colaborador_id"],
        nomeColaborador: json["nomeColaborador"],
        desconto: json["desconto"],
    );

    Map<String, dynamic> toJson() => {
        "idServico": idServico,
        "data_inicio": dataInicio,
        "data_final": dataFinal,
        "valor": valor,
        "mdo": mdo,
        "cliente_id": clienteId,
        "nomeCliente": nomeCliente,
        "telefone1": telefone1,
        "telefone2": telefone2,
        "garantia_id": garantiaId,
        "garantia": garantia,
        "carro_id": carroId,
        "modelo": modelo,
        "placa": placa,
        "sts_id": stsId,
        "sts": sts,
        "colaborador_id": colaboradorId,
        "nomeColaborador": nomeColaborador,
        "desconto": desconto,
    };
}