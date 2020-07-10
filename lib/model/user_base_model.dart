// To parse this JSON data, do
//
//     final userBaseModel = userBaseModelFromJson(jsonString);

import 'dart:convert';

UserBaseModel userBaseModelFromJson(String str) => UserBaseModel.fromJson(json.decode(str));

String userBaseModelToJson(UserBaseModel data) => json.encode(data.toJson());

class UserBaseModel {
    UserBaseModel({
        this.id,
        this.primeiroNome,
        this.ultimoNome,
        this.email,
        this.senha,
        this.tipo,
        this.loja,
        this.cpf,
        this.lojaNome,
        this.telefones,
        this.tokens,
    });

    String id;
    String primeiroNome;
    String ultimoNome;
    String email;
    String senha;
    String tipo;
    String loja;
    String cpf;
    String lojaNome;
    List<Telefone> telefones;
    List<Token> tokens;

    factory UserBaseModel.fromJson(Map<String, dynamic> json) => UserBaseModel(
        id: json["id"],
        primeiroNome: json["primeiro_nome"],
        ultimoNome: json["ultimo_nome"],
        email: json["email"],
        senha: json["senha"],
        tipo: json["tipo"],
        loja: json["loja"],
        cpf: json["cpf"],
        lojaNome: json["loja_nome"],
        telefones: List<Telefone>.from(json["telefones"].map((x) => Telefone.fromJson(x))),
        tokens: List<Token>.from(json["tokens"].map((x) => Token.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "primeiro_nome": primeiroNome,
        "ultimo_nome": ultimoNome,
        "email": email,
        "senha": senha,
        "tipo": tipo,
        "loja": loja,
        "cpf": cpf,
        "loja_nome": lojaNome,
        "telefones": List<dynamic>.from(telefones.map((x) => x.toJson())),
        "tokens": List<dynamic>.from(tokens.map((x) => x.toJson())),
    };
}

class Telefone {
    Telefone({
        this.id,
        this.telefone,
        this.whatsapp,
        this.usuario,
    });

    String id;
    String telefone;
    String whatsapp;
    String usuario;

    factory Telefone.fromJson(Map<String, dynamic> json) => Telefone(
        id: json["id"],
        telefone: json["telefone"],
        whatsapp: json["whatsapp"],
        usuario: json["usuario"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "telefone": telefone,
        "whatsapp": whatsapp,
        "usuario": usuario,
    };
}

class Token {
    Token({
        this.id,
        this.usuario,
        this.token,
    });

    String id;
    String usuario;
    String token;

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        id: json["id"],
        usuario: json["usuario"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "token": token,
    };
}
