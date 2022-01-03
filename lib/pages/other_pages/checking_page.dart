import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/log_in.dart';
import 'package:jobs_way/pages/main_pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckingPage extends StatefulWidget {
  const CheckingPage({Key? key}) : super(key: key);

  @override
  _CheckingPageState createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {

  final widgets = Get.put(WidgetController());

  var login = '';
  var premium = '';

  Future<void> retrieveData() async {
    final preferences = await SharedPreferences.getInstance();
    String? loginGet = preferences.getString("login");
    String? premiumGet = preferences.getString("premium");

    if(premiumGet != null){
      premium = premiumGet;
    }
    if(loginGet != null){
      login = loginGet;
    }
  }

  @override
  void initState() {
    super.initState();
    retrieveData().whenComplete(() {

      if(premium == 'premium'){
        widgets.premiumActivate();
      }

      if (login == 'login') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LogIn(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
