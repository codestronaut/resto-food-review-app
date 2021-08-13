import 'package:flutter/material.dart';
import 'package:resto/screens/widgets/builder/build_widget.dart';
import 'package:resto/screens/widgets/builder/platform_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: (context) => BuildWidget.android(
        context: context,
        appBarTitle: 'Settings',
        appBarElevation: 2.0,
        body: Container(),
      ),
      iosBuilder: (context) => BuildWidget.iOS(
        context: context,
        navBarTitle: 'Settings',
        hasBorder: true,
        body: Container(),
      ),
    );
  }
}
