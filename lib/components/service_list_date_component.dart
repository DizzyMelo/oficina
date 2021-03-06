import 'package:flutter/material.dart';
import 'package:oficina/components/service_row_date_component.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/view/service_view.dart';

class ServiceListDateComponent extends StatelessWidget {
  final List<ServiceModel> services;

  ServiceListDateComponent(this.services);
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView.builder(
            itemExtent: 55,
            itemCount: services.length,
            itemBuilder: (context, index) {
              ServiceModel serviceModel = services[index];
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServiceView(
                                  serviceModel: serviceModel,
                                )));
                  },
                  child: ServiceRowDateComponent(serviceModel));
            }));
  }
}
