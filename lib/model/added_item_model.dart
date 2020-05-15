// To parse this JSON data, do
//
//     final itemAdicionadoModel = itemAdicionadoModelFromJson(jsonString);

import 'dart:convert';

ItemAdicionadoModel itemAdicionadoModelFromJson(String str) => ItemAdicionadoModel.fromJson(json.decode(str));

String itemAdicionadoModelToJson(ItemAdicionadoModel data) => json.encode(data.toJson());

class ItemAdicionadoModel {
    List<ProdutosAdicionado> produtosAdicionados;
    Valores valores;

    ItemAdicionadoModel({
        this.produtosAdicionados,
        this.valores,
    });

    factory ItemAdicionadoModel.fromJson(Map<String, dynamic> json) => ItemAdicionadoModel(
        produtosAdicionados: List<ProdutosAdicionado>.from(json["produtosAdicionados"].map((x) => ProdutosAdicionado.fromJson(x))),
        valores: Valores.fromJson(json["valores"]),
    );

    Map<String, dynamic> toJson() => {
        "produtosAdicionados": List<dynamic>.from(produtosAdicionados.map((x) => x.toJson())),
        "valores": valores.toJson(),
    };
}

class ProdutosAdicionado {
    String produtoId;
    String nome;
    String valorVenda;
    String qtd;
    String valorTotal;

    ProdutosAdicionado({
        this.produtoId,
        this.nome,
        this.valorVenda,
        this.qtd,
        this.valorTotal,
    });

    factory ProdutosAdicionado.fromJson(Map<String, dynamic> json) => ProdutosAdicionado(
        produtoId: json["produto_id"],
        nome: json["nome"],
        valorVenda: json["valor_venda"],
        qtd: json["qtd"],
        valorTotal: json["valor_total"],
    );

    Map<String, dynamic> toJson() => {
        "produto_id": produtoId,
        "nome": nome,
        "valor_venda": valorVenda,
        "qtd": qtd,
        "valor_total": valorTotal,
    };
}

class Valores {
    String valor;
    String valorTotal;
    String mdo;
    String desconto;

    Valores({
        this.valor,
        this.valorTotal,
        this.mdo,
        this.desconto,
    });

    factory Valores.fromJson(Map<String, dynamic> json) => Valores(
        valor: json["valor"],
        valorTotal: json["valorTotal"],
        mdo: json["mdo"],
        desconto: json["desconto"],
    );

    Map<String, dynamic> toJson() => {
        "valor": valor,
        "valorTotal": valorTotal,
        "mdo": mdo,
        "desconto": desconto,
    };
}
