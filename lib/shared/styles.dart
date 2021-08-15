import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = Color(0xFFFFA000);
final Color backgroundColor = Color(0xFFF5F5F7);

final Color darkPrimaryColor = Color(0xFF000000);
final Color darkSecondaryColor = Color(0xFFFFA000);
final Color darkBackgroundColor = Color(0xFF212121);

final TextTheme restoTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    fontSize: 92,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.poppins(
    fontSize: 57,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.poppins(
    fontSize: 46,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.poppins(
    fontSize: 23,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.poppins(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: secondaryColor,
  scaffoldBackgroundColor: backgroundColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: restoTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: restoTextTheme.apply(bodyColor: Colors.black),
    elevation: 2.0,
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: darkPrimaryColor,
  accentColor: darkSecondaryColor,
  scaffoldBackgroundColor: darkBackgroundColor,
  canvasColor: darkPrimaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: restoTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: restoTextTheme.apply(bodyColor: Colors.white),
    elevation: 2.0,
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
);
