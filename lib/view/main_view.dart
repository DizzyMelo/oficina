import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/model/user_model.dart';
import 'package:oficina/service/service_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class MainView extends StatefulWidget {
  final UserModel user;

  MainView({this.user});
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<ServiceModel> services = new List();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(LineIcons.close),
                  onPressed: () => Navigator.pop(context)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    //width: screen.width * 0.3,

                    height: screen.height,
                    color: Colors.pink,
                    child: Column(
                      children: [
                        Container(
                          height: 1,
                          width: double.infinity,
                        ),
                        Text(
                          "Olá, ${Utils.formatFirstName(widget.user.nome)}"
                              .toUpperCase(),
                          style: Style.welcomeText,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                    flex: 7,
                    child: Container(
                      //width: screen.width * 0.7,
                      height: screen.height - 200,
                      child: Scrollbar(
                          child: ListView.builder(
                              itemCount: services.length,
                              itemBuilder: (context, index) {
                                ServiceModel serviceModel = services[index];
                                return ListTile(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/service', arguments: serviceModel),
                                  title: Text(serviceModel.nomeCliente),
                                  subtitle: Text(
                                      "${serviceModel.modelo} - ${serviceModel.telefone1}"),
                                );
                              })),
                    ))
              ],
            )
          ],
        )),
      ),
    );
  }

  getServices() async {
    List<ServiceModel> s = await ServiceService.getServices(widget.user.lojaId);
    if (s != null) {
      setState(() {
        services = s;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getServices();
  }
}
