import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/controller/service_controller.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';

class SelectColaboratorWaitingView extends StatefulWidget {
  final String serviceId;

  SelectColaboratorWaitingView({@required this.serviceId});
  @override
  _SelectColaboratorWaitingViewState createState() =>
      _SelectColaboratorWaitingViewState();
}

class _SelectColaboratorWaitingViewState
    extends State<SelectColaboratorWaitingView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SearchUserDataModel users;
  User colaborator;
  UserController _userController;
  ServiceController _serviceController = ServiceController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.plus,
              title: 'Selecionar Colaborador',
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    loading
                        ? Expanded(
                            child: Center(
                              child: LoadingComponent(),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemCount: users.data.users.length,
                                itemBuilder: (context, index) {
                                  User user = users.data.users[index];
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        colaborator = user;
                                      });
                                    },
                                    title: Text(
                                      user.name,
                                      style: Style.clientNameText,
                                    ),
                                  );
                                }),
                          ),
                    ListTile(
                      leading: Icon(
                        colaborator == null
                            ? LineIcons.warning
                            : LineIcons.check,
                        color: colaborator == null
                            ? Colors.red
                            : Style.primaryColor,
                      ),
                      title: Text(
                        colaborator == null
                            ? 'Colaborador não selecionado'
                            : 'Colaborador selecionado: ${colaborator.name}',
                        style: Style.clientNameText,
                      ),
                      trailing: colaborator == null
                          ? null
                          : IconButton(
                              icon: Icon(
                                LineIcons.close,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  colaborator = null;
                                });
                              }),
                    ),
                    MainButtomComponent(title: 'CONTINUAR', function: edit),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getColaborators() async {
    this.changeLodingState();
    SearchUserDataModel res = await _userController.getColaborators(
        SessionVariables.userDataModel.data.data.shop.id,
        context,
        _scaffoldKey);
    this.changeLodingState();

    if (res != null) {
      setState(() {
        users = res;
      });
    }
  }

  edit() async {
    if (colaborator == null) return;
    Map<String, dynamic> data = {
      'colaborator': colaborator.id,
      'status': 'iniciado'
    };
    bool res =
        await _serviceController.edit(data, widget.serviceId, '', context);

    if (res) {
      this.navigateToMain();
    }
  }

  navigateToMain() async {
    Navigator.pushNamed(context, '/manage_service',
        arguments: widget.serviceId);
  }

  changeLodingState() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  void initState() {
    super.initState();
    _userController = UserController();
    this.getColaborators();
  }
}
