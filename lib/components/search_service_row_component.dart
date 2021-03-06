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
      leading: Padding(
        padding: EdgeInsets.all(10),
        child: CircleAvatar(
          maxRadius: 5,
          backgroundColor: Utils.selectServiceColor(service.status),
        ),
      ),
      title: Text(
        service.car.name,
        style: Style.mainClientNameText,
      ),
      subtitle: Text(
        service.colaborator == null
            ? 'Não informado'
            : service.colaborator.name,
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
            service.dateEnd == null ? '-----' : Utils.formatDate(service.date),
            style: Style.phoneText,
          ),
        ],
      ),
    );
    ;
  }
}
