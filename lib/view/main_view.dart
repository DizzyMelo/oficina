import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/service_group_component.dart';
import 'package:oficina/components/service_row_component.dart';
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
  bool s1 = true;
  bool s2 = false;
  bool s3 = false;

  PageController controller = PageController(initialPage: 0);
  TextEditingController ctrSearch = TextEditingController();

  List<ServiceModel> services = new List();
  List<ServiceModel> supportServices = new List();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: screen.height,
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
                                              columnCount:
                                                  MenuList.listMenu.length,
                                              child: SlideAnimation(
                                                  verticalOffset: 50,
                                                  child: FadeInAnimation(
                                                    child: InkWell(
                                                      onTap: () =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              item.screen),
                                                      child: Container(
                                                        margin: index.isEven
                                                            ? EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10,
                                                                right: 5,
                                                                left: 10)
                                                            : EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10,
                                                                right: 10,
                                                                left: 5),
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
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
                      child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        child: Row(
                          children: [
                            ServiceGroupComponent('Em Progresso', () {
                              selectGroup(1);
                            }, s1),
                            ServiceGroupComponent('Em Espera', () {
                              selectGroup(2);
                            }, s2),
                            ServiceGroupComponent('Concluído', () {
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
                            ListView.builder(
                                itemExtent: 55,
                                itemCount: services.length,
                                itemBuilder: (context, index) {
                                  ServiceModel serviceModel = services[index];
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ServiceView(
                                                      serviceModel:
                                                          serviceModel,
                                                    )));
                                      },
                                      child: ServiceRowComponent(serviceModel));
                                }),
                            ListView.builder(
                                itemExtent: 55,
                                itemCount: services.length,
                                itemBuilder: (context, index) {
                                  ServiceModel serviceModel = services[index];
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ServiceView(
                                                      serviceModel:
                                                          serviceModel,
                                                    )));
                                      },
                                      child: ServiceRowComponent(serviceModel));
                                }),
                            ListView.builder(
                                itemExtent: 55,
                                itemCount: services.length,
                                itemBuilder: (context, index) {
                                  ServiceModel serviceModel = services[index];
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ServiceView(
                                                      serviceModel:
                                                          serviceModel,
                                                    )));
                                      },
                                      child: ServiceRowComponent(serviceModel));
                                }),
                          ],
                        ),
                      ),
                    ],
                  )),
                )
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
    if (s != null) {
      setState(() {
        supportServices = s;
        services = s;
      });
    }
  }

  searchServices(String str) {
    List<ServiceModel> tempServices = new List();
    supportServices.forEach((element) {
      if(element.nomeCliente.toLowerCase().contains(str.toLowerCase()) || 
          element.nomeColaborador.toLowerCase().contains(str.toLowerCase()) ||
          element.modelo.toLowerCase().contains(str.toLowerCase()) ||
          element.telefone1.toLowerCase().contains(str.toLowerCase())){
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
  }
}
