import 'package:flutter/material.dart';
import 'package:myflutterapp/controller/app_controller.dart';

import '../common/constant.dart';

const themeColorData = <Color>[
  Colors.cyan,
  Colors.blue,
  Colors.indigo,
  Colors.deepPurple,
  Colors.green,
  Colors.teal,
  Colors.yellow,
  Colors.lime,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.red,
  Colors.pink,
  Colors.purple,
];

ThemeData lightTheme(int key) {
  return ThemeData.light().copyWith(
    primaryColor: themeColorData[key],
    appBarTheme: AppBarTheme(color: themeColorData[key]),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: themeColorData[key],
    ),
    inputDecorationTheme: InputDecorationTheme(
      iconColor: themeColorData[key],
      labelStyle: TextStyle(color: themeColorData[key]),
    ),
  );
}

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.grey,
  listTileTheme: const ListTileThemeData(
    textColor: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);

ThemeData getThemeData(int key) {
  if (appController.themeModel.value == Constant.darkThemeModel) {
    return darkTheme;
  }
  return lightTheme(key);
}
