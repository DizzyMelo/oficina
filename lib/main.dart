import 'package:flutter/material.dart';
import 'package:oficina/view/land_view.dart';
import 'package:oficina/view/login_view.dart';
import 'package:oficina/view/main_view.dart';
import 'package:oficina/view/service_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/main',
      onGenerateRoute: (RouteSettings settings){
        var page;
        print(settings.name);

        switch (settings.name) {
          case "/login":
            page =  MaterialPageRoute(builder: (context) => LoginView());
            break;
          case "/main":
            page =  MaterialPageRoute(builder: (context) => MainView(data: settings.arguments,));
            break;
          case "/service":
            page =  MaterialPageRoute(builder: (context) => ServiceView());
            break;
          
        }

        return page;
      },
      onUnknownRoute: (RouteSettings settings){
        return MaterialPageRoute(builder: (context) => LoginView());
      },
    );
  }
}