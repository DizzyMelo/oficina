// To parse this JSON data, do
//
//     final clientBaseModel = clientBaseModelFromJson(jsonString);

import 'dart:convert';

ClientBaseModel clientBaseModelFromJson(String str) => ClientBaseModel.fromJson(json.decode(str));

String clientBaseModelToJson(ClientBaseModel data) => json.encode(data.toJson());

class ClientBaseModel {
    ClientBaseModel({
        this.id,
        this.nome,
        this.telefone1,
        this.telefone2,
        this.cpf,
        this.endereco,
        this.senha,
        this.token,
        this.sts,
        this.loja,
        this.email,
    });

    String id;
    String nome;
    String telefone1;
    String telefone2;
    String cpf;
    String endereco;
    String senha;
    String token;
    String sts;
    String loja;
    String email;

    factory ClientBaseModel.fromJson(Map<String, dynamic> json) => ClientBaseModel(
        id: json["id"],
        nome: json["nome"],
        telefone1: json["telefone1"],
        telefone2: json["telefone2"],
        cpf: json["cpf"],
        endereco: json["endereco"],
        senha: json["senha"],
        token: json["token"],
        sts: json["sts"],
        loja: json["loja"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "telefone1": telefone1,
        "telefone2": telefone2,
        "cpf": cpf,
        "endereco": endereco,
        "senha": senha,
        "token": token,
        "sts": sts,
        "loja": loja,
        "email": email,
    };
}
