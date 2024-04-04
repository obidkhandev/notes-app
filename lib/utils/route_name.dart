import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screen/create_note/create_screen.dart';
import 'package:notes_app/screen/home/home_screen.dart';

class RouteName {
  static const String home = '/home';
  static const String splash = '/splash';
  static const String create = '/create';
}

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return navigate(HomeScreen());
      case RouteName.create:
        return navigate(CreateNotes());

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
