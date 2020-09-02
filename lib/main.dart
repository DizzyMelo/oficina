import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficina/view/client_view.dart';
import 'package:oficina/view/finish_service_view.dart';
import 'package:oficina/view/land_view.dart';
import 'package:oficina/view/login_view.dart';
import 'package:oficina/view/main_view.dart';
import 'package:oficina/view/new_car.dart';
import 'package:oficina/view/new_service_view.dart';
import 'package:oficina/view/service_view.dart';
import 'package:oficina/view/settings_view.dart';
import 'package:oficina/view/stock_view.dart';
import 'package:oficina/view/worker_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/style.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
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
      title: 'Oficina na Mão',
      theme: ThemeData(
        primarySwatch: Style.themeColor,
        textTheme: GoogleFonts.latoTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: token == null || token.isEmpty ? '/login' : '/main',
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
            page = MaterialPageRoute(builder: (context) => MainView());
            break;
          case "/service":
            page = MaterialPageRoute(
                builder: (context) => ServiceView(
                      serviceModel: settings.arguments,
                    ));
            break;
          case "/new_service":
            page = MaterialPageRoute(builder: (context) => NewServiceView());
            break;
          case "/new_car":
            String client = settings.arguments ?? '62';
            String clientName = settings.arguments ?? 'Daniel';
            page = MaterialPageRoute(
                builder: (context) => NewCarView(
                      clientName,
                      client: client,
                    ));
            break;
          case "/stock":
            page = MaterialPageRoute(builder: (context) => StockView());
            break;
          case "/worker":
            page = MaterialPageRoute(builder: (context) => WorkerView());
            break;
          case "/client":
            page = MaterialPageRoute(builder: (context) => ClientView());
            break;

          case "/finish_service":
            page = MaterialPageRoute(
                builder: (context) => FinishServiceView(
                      service: settings.arguments,
                    ));
            break;

          case "/settings":
            page = MaterialPageRoute(builder: (context) => SettingsView());
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
