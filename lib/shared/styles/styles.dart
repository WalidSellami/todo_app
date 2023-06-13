
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

 ThemeData lightTheme = ThemeData(
  fontFamily: 'Ubuntu',
  scaffoldBackgroundColor: Colors.grey.shade100,
  colorScheme: const ColorScheme.light(),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 25.0,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue.shade700,
    unselectedItemColor: Colors.grey.shade600,
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15.0,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 14.0,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue.shade700,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue.shade700,
  ),
  textTheme: TextTheme(
    // bodyText1: TextStyle(
    //   color: Colors.grey.shade900,
    //
    // ),
    // bodyText2: TextStyle(
    //   color: Colors.grey.shade500,
    //   fontSize: 16.0,
    //   fontWeight: FontWeight.bold,
    // ),
    displayMedium: TextStyle(
      color: Colors.grey.shade900,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 19.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(
      fontFamily: 'Ubunty',
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: TextStyle(
      fontFamily: 'Ubuntu',
      color: Colors.black,
    ),
    elevation: 20.0,
  ),
  listTileTheme: ListTileThemeData(
    iconColor: Colors.grey.shade700,
  ),
);

 ThemeData darkTheme = ThemeData(
  fontFamily: 'Ubuntu',
  primarySwatch: Colors.teal,
   colorScheme: const ColorScheme.dark(),
   scaffoldBackgroundColor: Colors.grey.shade800.withOpacity(.5),
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('161717'),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 25.0,
    backgroundColor: HexColor('161717'),
    selectedItemColor: HexColor('35c2c2'),
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15.0,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 14.0,
    ),
    unselectedItemColor: Colors.grey,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: HexColor('31acac'),

  ),
  textTheme: const TextTheme(
    // bodyText1: TextStyle(
    //   color: Colors.white,
    //   fontSize: 20.0,
    //   fontWeight: FontWeight.bold,
    // ),
    // bodyText2: TextStyle(
    //   color: Colors.grey.shade400,
    //   fontSize: 16.0,
    //   fontWeight: FontWeight.bold,
    // ),
    displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontSize: 19.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey.shade800.withOpacity(.6),
    titleTextStyle: const TextStyle(
        fontFamily: 'Ubuntu',
        color: Colors.white,
        fontWeight: FontWeight.bold,
    ),
    contentTextStyle: const TextStyle(
      fontFamily: 'Ubuntu',
      color: Colors.white,
    ),
    elevation: 20.0,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: HexColor('161717'),
  ),
  listTileTheme: ListTileThemeData(
    iconColor: Colors.grey.shade200,
    textColor: Colors.white,
  ),
);