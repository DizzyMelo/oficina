import 'package:flutter/material.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ServiceRowComponent extends StatelessWidget {
  final ServiceModel serviceModel;
  ServiceRowComponent(this.serviceModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceModel.nomeCliente.toUpperCase(),
                        style: Style.mainClientNameText,
                      ),
                      Text(
                        serviceModel.modelo.toUpperCase(),
                        style: Style.carNameText,
                      ),
                    ]),
              )),
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        serviceModel.telefone1,
                        style: Style.phoneText,
                      ),
                    ]),
              )),
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        serviceModel.nomeColaborador.toUpperCase(),
                        style: Style.workerNameText,
                      ),
                    ]),
              )),
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Utils.formatMoney(double.parse(serviceModel.valor)),
                        style: Style.totalValueText,
                      ),
                      Text(
                        Utils.formatMoney(double.parse(serviceModel.mdo)),
                        style: Style.mdoText,
                      ),
                    ]),
              )),
        ],
      ),
    );
  }
}
