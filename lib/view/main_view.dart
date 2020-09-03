import 'package:flutter/material.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_appbar_component.dart';
import 'package:oficina/components/service_group_component.dart';
import 'package:oficina/components/service_list_component.dart';
import 'package:oficina/components/side_menu_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/shared/style.dart';

class MainView extends StatefulWidget {
  final String userId;

  MainView({@required this.userId});
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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int qtdProgress = 0;
  int qtdWaiting = 0;
  int qtdConcluded = 0;

  bool loading = false;

  UserController _userController;
  GetUserDataModel _userDataModel;

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
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  height: 50,
                                  child: Row(
                                    children: [
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
                                  padding: EdgeInsets.symmetric(horizontal: 10),
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

  getUserInformation() async {
    GetUserDataModel res = await _userController.getUserInformation(
        widget.userId, context, _scaffoldKey);

    if (res != null) {
      setState(() {
        _userDataModel = res;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _userController = UserController();
    this.getUserInformation();
  }

  @override
  void dispose() {
    //channel.sink.close();
    super.dispose();
  }
}
