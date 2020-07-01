import 'dart:html';

import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/menu_item_component.dart';
import 'package:oficina/components/service_group_component.dart';
import 'package:oficina/components/service_list_component.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/model/user_model.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/service/service_service.dart';
import 'package:oficina/service/worker_service.dart';
import 'package:oficina/shared/menu_list.dart';
import 'package:oficina/shared/style.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MainView extends StatefulWidget {
  final UserModel user;

  MainView({this.user});
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool s1 = true;
  bool s2 = false;
  bool s3 = false;

  PageController controller = PageController(initialPage: 0);
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrMessage = TextEditingController();
  List<WorkerModel> workers = new List();
  List<String> list = [];

  List<ServiceModel> services = new List();
  List<ServiceModel> servicesWaiting = new List();
  List<ServiceModel> servicesConcluded = new List();

  int qtdProgress = 0;
  int qtdWaiting = 0;
  int qtdConcluded = 0;

  List<ServiceModel> supportServices = new List();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: screen.height,
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                  height: 60,
                  width: screen.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Text(
                        widget.user.lojaNome,
                        style: Style.shopNameText,
                      )),
                      Text(
                        widget.user.nome.toUpperCase(),
                        style: Style.userNameText,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: Center(
                          child: Icon(
                            LineIcons.user,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        height: screen.height,
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                                    itemCount: MenuList.listMenu.length,
                                    itemBuilder: (context, index) {
                                      MenuItem item = MenuList.listMenu[index];
                                      return ListTile(
                                        onTap: () => Navigator.pushNamed(
                                            context, item.screen),
                                        leading: Icon(item.icon),
                                        title: Text(
                                          item.title,
                                          style: Style.optionTitleText,
                                        ),
                                      );
                                    }))
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 7,
                      child: Container(
                          child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            child: Row(
                              children: [
                                ServiceGroupComponent(
                                    'Em Progresso  -  $qtdProgress', () {
                                  selectGroup(1);
                                }, s1),
                                ServiceGroupComponent(
                                    'Em Espera  -  $qtdWaiting', () {
                                  selectGroup(2);
                                }, s2),
                                ServiceGroupComponent(
                                    'Concluído  -  $qtdConcluded', () {
                                  selectGroup(3);
                                }, s3),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              onChanged: searchServices,
                              controller: ctrSearch,
                              style: Style.searchText,
                              decoration: InputDecoration(
                                  hintText: 'Buscar Serviço...',
                                  hintStyle: Style.searchText,
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: PageView(
                              controller: controller,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                ServiceListComponent(services),
                                ServiceListComponent(servicesWaiting),
                                ServiceListComponent(servicesConcluded)
                              ],
                            ),
                          ),
                        ],
                      )),
                    ),
                    Flexible(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(top: 5),
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                      child: Scrollbar(
                                child: ListView.builder(
                                    itemCount: workers.length,
                                    itemBuilder: (context, index) {
                                      WorkerModel w = workers[index];
                                      return Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        height: 50,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Stack(
                                              overflow: Overflow.visible,
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 16,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: 2,
                                                      color: Colors.grey[100]
                                                    )
                                                  ),
                                                ))
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(w.nome ?? 'Colaborador',
                                                style: Style.workerNameText,
                                                overflow: TextOverflow.fade)
                                          ],
                                        ),
                                      );
                                    }),
                              ))),
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 0.5,
                                            color: Colors.grey[800]))),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children:
                                          list.map((e) => Text(e)).toList(),
                                    ),
                                    TextField(
                                      style: Style.messageText,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              icon:
                                                  Icon(LineIcons.paper_plane_o),
                                              onPressed: (){})),
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ))
                  ],
                )),
              ],
            )),
      ),
    );
  }

  selectGroup(int s) {
    controller.animateToPage(s - 1,
        duration: Duration(milliseconds: 700), curve: Curves.easeIn);
    setState(() {
      s1 = false;
      s2 = false;
      s3 = false;

      switch (s) {
        case 1:
          s1 = true;
          break;

        case 2:
          s2 = true;
          break;

        case 3:
          s3 = true;
          break;
        default:
      }
    });
  }

  getServices() async {
    List<ServiceModel> s = await ServiceService.getServices(widget.user.lojaId);

    List<ServiceModel> temp1 = new List();
    List<ServiceModel> temp2 = new List();
    List<ServiceModel> temp4 = new List();

    if (s != null) {
      s.forEach((element) {
        if (element.sts == 'Em espera') {
          temp1.add(element);
        } else if (element.sts == 'Iniciado') {
          temp2.add(element);
        } else if (element.sts == 'Concluido') {
          temp4.add(element);
        }
      });

      setState(() {
        supportServices = s;
        services = temp2;
        servicesWaiting = temp1;
        servicesConcluded = temp4;

        qtdProgress = services.length;
        qtdWaiting = servicesWaiting.length;
        qtdConcluded = servicesConcluded.length;
      });
    }
  }

  getWorkers() async {
    List<WorkerModel> wk = await WorkerService.getWorkers('1');

    if (wk != null && wk.length > 0) {
      setState(() {
        workers = wk;
      });
    }
  }

  searchServices(String str) {
    List<ServiceModel> tempServices = new List();
    supportServices.forEach((element) {
      if (element.nomeCliente.toLowerCase().contains(str.toLowerCase()) ||
          element.nomeColaborador.toLowerCase().contains(str.toLowerCase()) ||
          element.modelo.toLowerCase().contains(str.toLowerCase()) ||
          element.telefone1.toLowerCase().contains(str.toLowerCase())) {
        tempServices.add(element);
      }
    });

    setState(() {
      services = tempServices;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getServices();
    this.getWorkers();

    //channel = IOWebSocketChannel.connect('echo.websocket.org');
    // channel.stream.listen((event) {
    //   setState(() {
    //     list.add(event);
    //   });
    // });
  }

  @override
  void dispose() {
    //channel.sink.close();
    super.dispose();
  }
}
