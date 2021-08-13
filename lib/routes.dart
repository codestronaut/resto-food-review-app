import 'package:flutter/material.dart';
import 'package:resto/screens/detail_screen.dart';
import 'package:resto/screens/home_screen.dart';
import 'package:resto/screens/list_screen.dart';
import 'package:resto/screens/review_screen.dart';
import 'package:resto/screens/search_screen.dart';

Map<String, WidgetBuilder> allRoute(BuildContext context) {
  return {
    HomeScreen.routeName: (context) => HomeScreen(),
    ListScreen.routeName: (context) => ListScreen(),
    DetailScreen.routeName: (context) => DetailScreen(
          id: ModalRoute.of(context)!.settings.arguments as String,
        ),
    SearchScreen.routeName: (context) => SearchScreen(),
    ReviewScreen.routeName: (context) => ReviewScreen(
          id: ModalRoute.of(context)!.settings.arguments as String,
        ),
  };
}
