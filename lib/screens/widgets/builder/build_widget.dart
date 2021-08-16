import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto/shared/styles.dart';

class BuildWidget {
  static Widget android({
    required BuildContext context,
    required String appBarTitle,
    double? appBarElevation,
    List<Widget>? appBarActions,
    required Widget body,
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: appBarElevation != null ? appBarElevation : 0.0,
        shadowColor: Colors.grey[200],
        title: Text(
          appBarTitle,
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
        actions: appBarActions,
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
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        border: Border.all(
          width: 0.0,
          color: hasBorder == true ? Color(0x4D000000) : Colors.transparent,
        ),
        backgroundColor: Colors.white,
        previousPageTitle: prevPageTitle,
        middle: Text(
          navBarTitle,
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
        transitionBetweenRoutes: false,
        trailing: navBarTrailing,
      ),
      child: body,
    );
  }
}
