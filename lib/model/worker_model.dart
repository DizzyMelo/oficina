// To parse this JSON data, do
//
//     final workerModel = workerModelFromJson(jsonString);

import 'dart:convert';

WorkerModel workerModelFromJson(String str) => WorkerModel.fromJson(json.decode(str));

String workerModelToJson(WorkerModel data) => json.encode(data.toJson());

class WorkerModel {
    String id;
    String nome;
    String telefone;
    String funcaoId;
    String token;
    String lojaId;
    String endereco;
    bool selecionado = false;

    WorkerModel({
        this.id,
        this.nome,
        this.telefone,
        this.funcaoId,
        this.token,
        this.lojaId,
        this.endereco,
        this.selecionado
    });

    factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
        id: json["id"],
        nome: json["nome"],
        telefone: json["telefone"],
        funcaoId: json["funcao_id"],
        token: json["token"],
        lojaId: json["loja_id"],
        endereco: json["endereco"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "telefone": telefone,
        "funcao_id": funcaoId,
        "token": token,
        "loja_id": lojaId,
        "endereco": endereco,
    };
}
