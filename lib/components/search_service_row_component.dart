import 'package:flutter/material.dart';
import 'package:oficina/model/report_service_data_model.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class SearchServiceRowComponent extends StatelessWidget {
  final Service service;

  SearchServiceRowComponent({@required this.service});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/manage_service', arguments: service.id);
      },
      title: Text(
        service.car.name,
        style: Style.mainClientNameText,
      ),
      subtitle: Text(
        service.colaborator.name,
        style: Style.carNameText,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Utils.formatMoney(service.value),
            style: Style.totalValueText,
          ),
          Text(
            Utils.formatDate(service.date),
            style: Style.phoneText,
          ),
        ],
      ),
    );
    ;
  }
}
