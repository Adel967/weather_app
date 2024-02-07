import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/routing/route_paths.dart';
import 'package:weather/layers/presentation/screens/home_screen/home_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      case RoutePaths.HomeScreen :
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default: return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            // child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
    }
  }
}