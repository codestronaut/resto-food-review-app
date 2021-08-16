import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/helper/preferences_helper.dart';
import 'package:resto/providers/content/resto_detail_provider.dart';
import 'package:resto/providers/content/resto_list_provider.dart';
import 'package:resto/providers/content/resto_review_provider.dart';
import 'package:resto/providers/content/resto_search_provider.dart';
import 'package:resto/providers/preferences_provider.dart';
import 'package:resto/routes.dart';
import 'package:resto/screens/home_screen.dart';
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
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            title: 'Resto',
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return CupertinoTheme(
                data: lightThemeIOS,
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
