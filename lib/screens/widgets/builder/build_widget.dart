import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto/shared/constants.dart';

class BuildWidget {
  static Widget android({
    required BuildContext context,
    required String appBarTitle,
    double? appBarElevation,
    List<Widget>? appBarActions,
    required Widget body,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: body,
    );
  }

  static Widget iOS({
    required BuildContext context,
    required String navBarTitle,
    String? prevPageTitle,
    Widget? navBarTrailing,
    required Widget body,
    bool? hasBorder = false,
  }) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: prevPageTitle,
        middle: Text(navBarTitle),
        transitionBetweenRoutes: false,
      ),
      child: body,
    );
  }
}
