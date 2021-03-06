import 'package:flutter/material.dart';
import 'package:oficina/model/report_service_data_model.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ServiceRowComponent extends StatelessWidget {
  final Service serviceModel;
  ServiceRowComponent(this.serviceModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          if (serviceModel.status == 'espera') {
            Navigator.pushNamed(context, '/select_colaborator_waiting',
                arguments: serviceModel.id);
          } else if (serviceModel.status == 'concluido') {
            Navigator.pushNamed(context, '/manage_finished_service',
                arguments: serviceModel.id);
          } else {
            Navigator.pushNamed(context, '/manage_service',
                arguments: serviceModel.id);
          }
        },
        child: Material(
          borderRadius: BorderRadius.circular(5),
          elevation: 10,
          shadowColor: Style.secondaryColor,
          child: Container(
            //margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 5,
                          backgroundColor:
                              Utils.selectServiceColor(serviceModel.status),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceModel.client == null
                                    ? 'Não informado'
                                    : serviceModel.client.name,
                                style: Style.mainClientNameText,
                              ),
                              Text(
                                serviceModel.car == null
                                    ? 'Não informado'
                                    : serviceModel.car.name,
                                style: Style.carNameText,
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            serviceModel.client == null
                                ? 'Não informado'
                                : Utils.formatPhone(
                                    serviceModel.client.primaryphone),
                            style: Style.phoneText,
                          ),
                          Text(
                            serviceModel.client == null
                                ? 'Não informado'
                                : serviceModel.client.secondaryphone ?? '-----',
                            style: Style.phoneText,
                          ),
                        ]),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            serviceModel.colaborator == null
                                ? 'Não informado'
                                : serviceModel.colaborator.name,
                            style: Style.workerNameText,
                          ),
                        ]),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            Utils.formatMoney(serviceModel.value.toDouble()),
                            style: Style.totalValueText,
                          ),
                          // Text(
                          //   Utils.formatMoney(serviceModel.how.toDouble()),
                          //   style: Style.mdoText,
                          // ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
