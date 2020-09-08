import 'package:flutter/material.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_appbar_component.dart';
import 'package:oficina/components/service_group_component.dart';
import 'package:oficina/components/service_row_component.dart';
import 'package:oficina/components/side_menu_component.dart';
import 'package:oficina/controller/shop_controller.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/get_services_data_model.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/shared/style.dart';

class MainView extends StatefulWidget {
  final String userId;

  MainView({@required this.userId});
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool s1 = false;
  bool s2 = false;
  bool s3 = false;
  bool s4 = true;

  PageController controller = PageController(initialPage: 0);
  TextEditingController ctrSearch = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int qtdProgress = 0;
  int qtdWaiting = 0;
  int qtdConcluded = 0;

  bool loading = false;
  bool loadingServices = false;

  UserController _userController;
  ShopController _shopController;

  GetUserDataModel _userDataModel;
  GetServiceDataModel _serviceDataModel;

  List<ServiceModel> supportServices = new List();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: screen.height,
          child: _userDataModel == null
              ? Center(
                  child: LoadingComponent(),
                )
              : Column(
                  children: [
                    MainAppbarComponent(user: _userDataModel),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(flex: 2, child: SideMenuComponent()),
                          Flexible(
                            flex: 7,
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      children: [
                                        ServiceGroupComponent(
                                            'Todos  -  $qtdProgress', () {
                                          selectGroup(4);
                                        }, s4),
                                        ServiceGroupComponent(
                                            'Iniciado  -  $qtdProgress', () {
                                          selectGroup(1);
                                        }, s1),
                                        ServiceGroupComponent(
                                            'Espera  -  $qtdWaiting', () {
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
                                      onChanged: (str) {},
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
                                    child: _serviceDataModel == null ||
                                            _serviceDataModel
                                                    .data.data.length ==
                                                0
                                        ? Center(
                                            child: Text(
                                                'Nenhum serviço a ser exibido'),
                                          )
                                        : ListView.builder(
                                            itemCount: _serviceDataModel
                                                .data.data.length,
                                            itemBuilder: (context, index) {
                                              Datum data = _serviceDataModel
                                                  .data.data[index];
                                              return ServiceRowComponent(
                                                data,
                                                function: () {
                                                  Navigator.pushNamed(
                                                      context, '/service',
                                                      arguments: data.id);
                                                },
                                              );
                                            }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
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
      s4 = false;

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

        case 4:
          s4 = true;
          break;
        default:
      }
    });
  }

  getUserInformation() async {
    GetUserDataModel res = await _userController.getUserInformation(
        widget.userId, context, _scaffoldKey);

    if (res != null) {
      setState(() {
        _userDataModel = res;
      });
    }
  }

  getServices() async {
    GetServiceDataModel res = await _shopController.getServices(_scaffoldKey);

    if (res != null) {
      setState(() {
        _serviceDataModel = res;
      });
    } else {
      print('objeto nulo');
    }
  }

  executeInitMethods() async {
    await this.getUserInformation();
    await this.getServices();
  }

  @override
  void initState() {
    super.initState();
    _userController = UserController();
    _shopController = ShopController();
    this.executeInitMethods();
  }

  @override
  void dispose() {
    //channel.sink.close();
    super.dispose();
  }
}
