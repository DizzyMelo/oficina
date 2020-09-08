import 'package:flutter/material.dart';
import 'package:oficina/model/get_services_data_model.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ServiceRowComponent extends StatelessWidget {
  final Datum serviceModel;
  ServiceRowComponent(this.serviceModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/manage_service',
            arguments: serviceModel.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
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
                          serviceModel.client.name,
                          style: Style.mainClientNameText,
                        ),
                        Text(
                          serviceModel.car.name,
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
                          serviceModel.client.primaryphone,
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
                          serviceModel.colaborator.name,
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
                          Utils.formatMoney(serviceModel.value.toDouble()),
                          style: Style.totalValueText,
                        ),
                        Text(
                          Utils.formatMoney(serviceModel.how.toDouble()),
                          style: Style.mdoText,
                        ),
                      ]),
                )),
          ],
        ),
      ),
    );
  }
}
