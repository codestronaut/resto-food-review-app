import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto/data/api/api_service.dart';
import 'package:resto/providers/resto_detail_provider.dart';
import 'package:resto/providers/resto_list_provider.dart';
import 'package:resto/providers/resto_review_provider.dart';
import 'package:resto/providers/resto_search_provider.dart';
import 'package:resto/routes.dart';
import 'package:resto/screens/home_screen.dart';
import 'package:resto/screens/list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<RestoListProvider>(
          create: (_) => RestoListProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<RestoDetailProvider>(
          create: (_) => RestoDetailProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<RestoSearchProvider>(
          create: (_) => RestoSearchProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<RestoReviewProvider>(
          create: (_) => RestoReviewProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MaterialApp _buildAndroidParent(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      initialRoute: ListScreen.routeName,
      routes: allRoute(context),
    );
  }

  CupertinoApp _buildIOSParent(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        primaryColor: Colors.black,
      ),
      initialRoute: HomeScreen.routeName,
      routes: allRoute(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _buildAndroidParent(context);
      case TargetPlatform.iOS:
        return _buildIOSParent(context);
      default:
        return _buildAndroidParent(context);
    }
  }
}
