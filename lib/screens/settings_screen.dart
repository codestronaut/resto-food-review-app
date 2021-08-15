import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto/providers/preferences_provider.dart';
import 'package:resto/screens/widgets/builder/build_widget.dart';
import 'package:resto/screens/widgets/builder/platform_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Widget _buildContent(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: Text(
                  'Dark Mode',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: (context) => BuildWidget.android(
        context: context,
        appBarTitle: 'Settings',
        body: _buildContent(context),
      ),
      iosBuilder: (context) => BuildWidget.iOS(
        context: context,
        navBarTitle: 'Settings',
        body: _buildContent(context),
      ),
    );
  }
}
