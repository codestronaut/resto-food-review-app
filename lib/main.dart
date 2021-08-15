import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/preferences/preferences_helper.dart';
import 'package:resto/providers/preferences_provider.dart';
import 'package:resto/providers/resto_detail_provider.dart';
import 'package:resto/providers/resto_list_provider.dart';
import 'package:resto/providers/resto_review_provider.dart';
import 'package:resto/providers/resto_search_provider.dart';
import 'package:resto/routes.dart';
import 'package:resto/screens/home_screen.dart';
import 'package:resto/screens/list_screen.dart';
import 'package:resto/shared/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Resto',
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  scaffoldBackgroundColor: provider.isDarkTheme ? Colors.grey[900] : backgroundColor,
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            initialRoute: HomeScreen.routeName,
            routes: allRoute(context),
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  _buildAndroidParent(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: provider.themeData,
          initialRoute: ListScreen.routeName,
          routes: allRoute(context),
        );
      },
    );
  }

  _buildIOSParent(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: CupertinoThemeData(
            primaryColor: provider.isDarkTheme ? Colors.white : Colors.black,
            primaryContrastingColor:
                provider.isDarkTheme ? Colors.black : Colors.white,
            scaffoldBackgroundColor:
                provider.isDarkTheme ? Colors.black : backgroundColor,
            brightness:
                provider.isDarkTheme ? Brightness.dark : Brightness.light,
          ),
          initialRoute: HomeScreen.routeName,
          routes: allRoute(context),
        );
      },
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
