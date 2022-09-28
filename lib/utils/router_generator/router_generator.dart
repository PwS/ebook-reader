import 'package:ebook/ui/pages/dashboard/dashboard.dart';
import 'package:ebook/utils/router_generator/routes_value.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == RoutesValue.dashboardRoute) {
      return MaterialPageRoute(
          builder: (_) => const DashBoard(), settings: routeSettings);
    }

    switch (routeSettings.name) {
      default:
        return MaterialPageRoute(builder: (_) => const DashBoard());
    }
  }
}
