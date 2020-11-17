import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/view/client_view.dart';
import 'package:oficina/view/edit_user_view.dart';
import 'package:oficina/view/edit_product_view.dart';
import 'package:oficina/view/land_view.dart';
import 'package:oficina/view/login_view.dart';
import 'package:oficina/view/main_view.dart';
import 'package:oficina/view/manage_finished_service_view.dart';
import 'package:oficina/view/manage_service_view.dart';
import 'package:oficina/view/new_car.dart';
import 'package:oficina/view/new_service_view.dart';
import 'package:oficina/view/payment_view.dart';
import 'package:oficina/view/profile_view.dart';
import 'package:oficina/view/report_view.dart';
import 'package:oficina/view/select_car_view.dart';
import 'package:oficina/view/select_client_view.dart';
import 'package:oficina/view/select_colaborator_view.dart';
import 'package:oficina/view/select_colaborator_waiting_view.dart';
import 'package:oficina/view/service_view.dart';
import 'package:oficina/view/settings_view.dart';
import 'package:oficina/view/stock_view.dart';
import 'package:oficina/view/colaborator_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/style.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  SessionVariables.token = token;
  await DotEnv().load('config.env');
  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String token;

  MyApp(this.token);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oficinei',
      theme: ThemeData(
        primarySwatch: Style.themeColor,
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: token == null || token.isEmpty ? '/login' : '/main',
      //initialRoute: '/login',
      onGenerateRoute: (RouteSettings settings) {
        var page;

        switch (settings.name) {
          case "/land":
            page = MaterialPageRoute(builder: (context) => LandView());
            break;
          case "/login":
            page = MaterialPageRoute(builder: (context) => LoginView());
            break;
          case "/main":
            String userId = settings.arguments == null
                ? JwtDecoder.decode(token)['id']
                : settings.arguments;
            page = MaterialPageRoute(
                builder: (context) => MainView(
                      userId: userId,
                    ));
            break;
          case "/service":
            page = MaterialPageRoute(
                builder: (context) => ServiceView(
                      serviceModel: settings.arguments,
                    ));
            break;

          case "/manage_service":
            page = MaterialPageRoute(
                builder: (context) => ManageServiceView(
                      serviceId: settings.arguments,
                    ));
            break;

          case "/manage_finished_service":
            page = MaterialPageRoute(
                builder: (context) => ManageFinishedServiceView(
                      serviceId: settings.arguments,
                    ));
            break;
          case "/new_service":
            page = MaterialPageRoute(
                builder: (context) => NewServiceView(
                      newService: settings.arguments,
                    ));
            break;
          case "/new_car":
            page = MaterialPageRoute(
                builder: (context) => NewCarView(user: settings.arguments));
            break;
          case "/stock":
            page = MaterialPageRoute(builder: (context) => StockView());
            break;
          case "/colaborator":
            page = MaterialPageRoute(builder: (context) => ColaboratorView());
            break;
          case "/client":
            page = MaterialPageRoute(builder: (context) => ClientView());
            break;

          // case "/finish_service":
          //   page = MaterialPageRoute(
          //       builder: (context) => FinishServiceView(
          //             service: settings.arguments,
          //           ));
          //   break;

          case "/settings":
            page = MaterialPageRoute(builder: (context) => SettingsView());
            break;

          case "/select_client":
            page = MaterialPageRoute(builder: (context) => SelectClientView());
            break;

          case "/select_car":
            page = MaterialPageRoute(
              builder: (context) => SelectCarView(
                newService: settings.arguments,
              ),
            );
            break;

          case "/select_colaborator":
            page = MaterialPageRoute(
              builder: (context) => SelectColaboratorView(
                newService: settings.arguments,
              ),
            );
            break;

          case "/select_colaborator_waiting":
            page = MaterialPageRoute(
              builder: (context) => SelectColaboratorWaitingView(
                serviceId: settings.arguments,
              ),
            );
            break;

          case "/edit_product":
            page = MaterialPageRoute(
              builder: (context) => EditProductView(
                product: settings.arguments,
              ),
            );
            break;

          case "/edit_user":
            page = MaterialPageRoute(
              builder: (context) => EditUserView(
                user: settings.arguments,
              ),
            );
            break;

          case "/profile":
            page = MaterialPageRoute(
              builder: (context) => ProfileView(),
            );
            break;

          case "/payment":
            page = MaterialPageRoute(
              builder: (context) => PaymentView(
                service: settings.arguments,
              ),
            );
            break;

          case "/report":
            page = MaterialPageRoute(
              builder: (context) => ReportView(),
            );
            break;
        }

        return page;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => LoginView());
      },
    );
  }
}
