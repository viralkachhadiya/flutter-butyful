import 'package:Butyful/UI/home.dart';
import 'package:Butyful/UI/login.dart';
import 'package:Butyful/UI/production.dart';
import 'package:Butyful/UI/register.dart';
import 'package:Butyful/Utils/routes.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.Register:
        return MaterialPageRoute(builder: (_) => Register());
        break;
      case Routes.Home:
        return MaterialPageRoute(builder: (_) => Home());
        break;
      case Routes.Login:
        return MaterialPageRoute(builder: (_) => Login());
        break;
      case Routes.Production:
        return MaterialPageRoute(builder: (_) => Production());
        break;
      default:
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}
