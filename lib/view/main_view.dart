import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_appbar_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/service_row_component.dart';
import 'package:oficina/components/side_menu_component.dart';
import 'package:oficina/controller/service_controller.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/model/report_service_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class MainView extends StatefulWidget {
  final String userId;

  MainView({@required this.userId});
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  PageController controller = PageController(initialPage: 0);
  TextEditingController ctrSearch = TextEditingController();
  MaskedTextController ctrDateInit = MaskedTextController(mask: '00/00/0000');
  MaskedTextController ctrDateFinal = MaskedTextController(mask: '00/00/0000');

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool loadingServices = false;

  UserController _userController = UserController();
  ReportServiceDataModel report;

  ServiceController _serviceController = ServiceController();

  GetUserDataModel _userDataModel;
  List<Service> services = List();
  List<Service> waitingservices = List();

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
                            flex: 9,
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      child:
                                                          MainTextFieldComponent(
                                                              controller:
                                                                  ctrDateInit,
                                                              icon: LineIcons
                                                                  .calendar,
                                                              hint:
                                                                  'Data inicial'),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Flexible(
                                                    child: Container(
                                                      child:
                                                          MainTextFieldComponent(
                                                              controller:
                                                                  ctrDateFinal,
                                                              icon: LineIcons
                                                                  .calendar,
                                                              hint:
                                                                  'Data final'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                child: MainButtomComponent(
                                                    title: 'BUSCAR',
                                                    function: getReport),
                                              )
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
                                      onChanged: search,
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
                                    child: services.length == 0
                                        ? Center(
                                            child: Text(
                                                'Nenhum serviço a ser exibido'),
                                          )
                                        : Scrollbar(
                                            child: ListView.builder(
                                                itemCount: services.length,
                                                itemBuilder: (context, index) {
                                                  Service data =
                                                      services[index];
                                                  return ServiceRowComponent(
                                                      data);
                                                }),
                                          ),
                                  ),
                                  Container(
                                    height: 20,
                                    width: double.infinity,
                                    //color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      width: 0.5, color: Style.secondaryColor),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Text('LIST DA ESPERA'),
                                  SizedBox(height: 20),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 0.5,
                                    width: double.infinity,
                                    color: Style.secondaryColor,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: waitingservices.length,
                                        itemBuilder: (context, index) {
                                          Service service =
                                              waitingservices[index];
                                          return ListTile(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/select_colaborator_waiting',
                                                  arguments: service.id);
                                            },
                                            title: Text(service.client.name,
                                                style: TextStyle(fontSize: 13)),
                                            subtitle: Text(
                                              service.car.name,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            ),
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

  getUserInformation() async {
    GetUserDataModel res = await _userController.getUserInformation(
        widget.userId, context, _scaffoldKey);

    if (res != null) {
      setState(() {
        _userDataModel = res;
      });
    }
  }

  getReport() async {
    Map<String, dynamic> data = {
      "shop": SessionVariables.userDataModel.data.data.shop.id,
      "date": {
        "\$gte": Utils.formatDateReverse(ctrDateInit.text),
        "\$lte": "${Utils.formatDateReverse(ctrDateFinal.text)} 24:00:00"
      }
    };

    ReportServiceDataModel res =
        await _serviceController.report(data, _scaffoldKey);

    if (res != null) {
      setState(() {
        report = res;
        services = res.data.services.reversed.toList();

        res.data.services.forEach((element) {
          if (element.status == 'espera') waitingservices.add(element);
        });
      });
    }
  }

  search(String str) {
    services = report.data.services.reversed.toList();
    List<Service> tempServices = List();

    tempServices = services
        .where((s) =>
            s.client.name.toLowerCase().contains(str.toLowerCase()) ||
            (s.colaborator != null &&
                s.colaborator.name.toLowerCase().contains(str.toLowerCase())) ||
            s.value.toString().toLowerCase().contains(str.toLowerCase()) ||
            s.status.toString().toLowerCase().contains(str.toLowerCase()) ||
            (s.car != null &&
                s.car.name.toLowerCase().contains(str.toLowerCase())))
        .toList();

    setState(() {
      services = tempServices;
    });
  }

  executeInitMethods() async {
    await this.getUserInformation();
    await this.getReport();
  }

  @override
  void initState() {
    super.initState();
    ctrDateInit.text = Utils.getCurrentDate(days: 0); //days: -7
    ctrDateFinal.text = Utils.getCurrentDate();
    this.executeInitMethods();
  }
}
