import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/model/user_model.dart';
import 'package:oficina/service/service_service.dart';
import 'package:oficina/shared/menu_list.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';
import 'package:oficina/view/service_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
                    height: screen.height,
                    color: Colors.pink,
                    child: Column(
                      children: [
                        Container(
                          height: 1,
                          width: double.infinity,
                        ),
                        Expanded(
                            child: AnimationLimiter(
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemCount: MenuList.listMenu.length,
                                    itemBuilder: (context, index) {

                                      MenuItem item = MenuList.listMenu[index];

                                      return AnimationConfiguration
                                          .staggeredGrid(
                                              position: index,
                                              columnCount: MenuList.listMenu.length,
                                              child: SlideAnimation(
                                                  verticalOffset: 50,
                                                  child: FadeInAnimation(
                                                    child: InkWell(
                                                      onTap: () => Navigator.pushNamed(context, item.screen),
                                                      child: Container(
                                                        margin: index.isEven ? EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10) : EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 5),
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Icon(item.icon),
                                                            Text(item.title)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )));
                                    })))
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
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                            flex: 1,
                                            child: Container(
                                              width: double.infinity,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      serviceModel.nomeCliente
                                                          .toUpperCase(),
                                                      style: Style
                                                          .mainClientNameText,
                                                    ),
                                                    Text(
                                                      serviceModel.modelo
                                                          .toUpperCase(),
                                                      style: Style.carNameText,
                                                    ),
                                                  ]),
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Container(
                                              width: double.infinity,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      serviceModel.telefone1,
                                                      style: Style.phoneText,
                                                    ),
                                                    // Text(
                                                    //   serviceModel.placa
                                                    //       .toUpperCase(),
                                                    //   style: Style.plateText,
                                                    // ),
                                                  ]),
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Container(
                                              width: double.infinity,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      serviceModel
                                                          .nomeColaborador
                                                          .toUpperCase(),
                                                      style: Style
                                                          .mainClientNameText,
                                                    ),
                                                  ]),
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Container(
                                              width: double.infinity,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      Utils.formatMoney(
                                                          double.parse(
                                                              serviceModel
                                                                  .valor)),
                                                      style:
                                                          Style.totalValueText,
                                                    ),
                                                    Text(
                                                      Utils.formatMoney(
                                                          double.parse(
                                                              serviceModel
                                                                  .mdo)),
                                                      style: Style.mdoText,
                                                    ),
                                                  ]),
                                            )),
                                      ],
                                    ),
                                  ),
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
