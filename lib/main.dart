import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/login_signup/log_in.dart';
import 'package:jobs_way/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_signup/sign_up.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  var login = '';

  Future<void> retrieveData() async{
    final preferences = await SharedPreferences.getInstance();
    String? loginGet = preferences.getString("login");
    login = loginGet!;
  }

  @override
  Widget build(BuildContext context) {
    retrieveData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'jobs way app',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF004756)),
      ),
      home: login == 'login' ?
      HomePage() :
      const LogIn(),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

}
