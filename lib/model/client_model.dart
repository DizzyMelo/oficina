// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
    String clienteId;
    String clienteNome;
    String telefone1;
    String telefone2;
    String cpf;
    String email;
    String carro;
    String placa;
    bool selecionado;

    ClientModel({
        this.clienteId,
        this.clienteNome,
        this.telefone1,
        this.telefone2,
        this.cpf,
        this.email,
        this.carro,
        this.placa,
        this.selecionado = false
    });

    factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        clienteId: json["clienteId"],
        clienteNome: json["clienteNome"].toUpperCase(),
        telefone1: json["telefone1"],
        telefone2: json["telefone2"],
        cpf: json["cpf"],
        email: json["email"],
        carro: json["carro"].toUpperCase(),
        placa: json["placa"].toUpperCase().trim(),
    );

    Map<String, dynamic> toJson() => {
        "clienteId": clienteId,
        "clienteNome": clienteNome,
        "telefone1": telefone1,
        "telefone2": telefone2,
        "cpf": cpf,
        "email": email,
        "carro": carro,
        "placa": placa,
    };
}
