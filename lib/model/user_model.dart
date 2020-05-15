// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String nome;
    String telefone;
    String endereco;
    String funcaoId;
    String senha;
    String token;
    String lojaId;
    String sts;
    String login;
    String lojaNome;

    UserModel({
        this.id,
        this.nome,
        this.telefone,
        this.endereco,
        this.funcaoId,
        this.senha,
        this.token,
        this.lojaId,
        this.sts,
        this.login,
        this.lojaNome,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nome: json["nome"],
        telefone: json["telefone"],
        endereco: json["endereco"],
        funcaoId: json["funcao_id"],
        senha: json["senha"],
        token: json["token"],
        lojaId: json["loja_id"],
        sts: json["sts"],
        login: json["login"],
        lojaNome: json["lojaNome"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "telefone": telefone,
        "endereco": endereco,
        "funcao_id": funcaoId,
        "senha": senha,
        "token": token,
        "loja_id": lojaId,
        "sts": sts,
        "login": login,
        "lojaNome": lojaNome,
    };
}
