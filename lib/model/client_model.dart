// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
    ClientModel({
        this.informacoes,
        this.carros,
        this.selecionado = false
    });

    Informacoes informacoes;
    List<Carro> carros;
    bool selecionado;

    factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        informacoes: Informacoes.fromJson(json["informacoes"]),
        carros: List<Carro>.from(json["carros"].map((x) => Carro.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "informacoes": informacoes.toJson(),
        "carros": List<dynamic>.from(carros.map((x) => x.toJson())),
    };
}

class Carro {
    Carro({
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

    factory Carro.fromJson(Map<String, dynamic> json) => Carro(
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

class Informacoes {
    Informacoes({
        this.clienteId,
        this.clienteNome,
        this.telefone1,
        this.telefone2,
        this.cpf,
        this.email,
    });

    String clienteId;
    String clienteNome;
    String telefone1;
    String telefone2;
    String cpf;
    String email;

    factory Informacoes.fromJson(Map<String, dynamic> json) => Informacoes(
        clienteId: json["clienteId"],
        clienteNome: json["clienteNome"],
        telefone1: json["telefone1"],
        telefone2: json["telefone2"],
        cpf: json["cpf"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "clienteId": clienteId,
        "clienteNome": clienteNome,
        "telefone1": telefone1,
        "telefone2": telefone2,
        "cpf": cpf,
        "email": email,
    };
}
