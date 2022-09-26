import 'package:flutter/material.dart';

class RouterGenerator {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
