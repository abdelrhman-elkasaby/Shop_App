import 'package:flutter/material.dart';

class MyColors {
  static const whiteColor = const Color(0xFFFFFFFF);
  static const blackColor = const Color(0xFF000000);
  static const greyColor = const Color(0xff707070);
  static const lightGreyColor = const Color(0xFFBDBDBD);
  static const primaryColor = const Color(0xff424143);
  static const redColor = const Color(0xffFF3B30);
  static const greenColor = const Color(0xff59B95F);
  static ThemeData themeData=ThemeData(
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
      ),
      primaryIconTheme: IconThemeData(color: Colors.blue),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      indicatorColor: Colors.blue,
      primarySwatch: Colors.blue,
      canvasColor: Colors.white
  );

}
