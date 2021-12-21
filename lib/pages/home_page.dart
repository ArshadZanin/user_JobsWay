import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/log_in.dart';
import 'package:jobs_way/model/otp_signup_model.dart';
import 'package:jobs_way/pages/featured_jobs.dart';
import 'package:jobs_way/pages/home_screen_page.dart';
import 'package:jobs_way/pages/my_jobs_page.dart';
import 'package:jobs_way/pages/settings_page.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  HomePage({userDetails, Key? key}) : super(key: key);
  UserModelOtp? userDetails;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final widgets = Get.put(WidgetController());

  Future<void> loginUser({
    required String password,
    required String phone,
  }) async {

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("id");
    String id = '';
    if(idGet != null){
      id = idGet;
    }else{
      preferences.clear();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LogIn(),),);
    }

    try {
      String apiUrl =
          'https://jobsway-user.herokuapp.com/api/v1/user/user/$id';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseString = response.body;

        print(response.body);
        // return userModelOtpFromJson(responseString);
      } else {
        // return null;
      }
    } on SocketException {
      Get.snackbar('Something went Wrong!', 'Check network connection',
          icon: const Icon(Icons.network_check_outlined));
    } on TimeoutException catch (e) {
      Get.snackbar(
        'Something went Wrong!',
        '$e',
      );
    } on Error catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Obx(() {
        return Scaffold(
          appBar: widgets.appbarCustom(context),
          body: TabBarView(
            children: <Widget>[
              const HomeScreenPage(),
              FeaturedJobsPage(),
              const MyJobsPage(),
              const SettingsPage(),
            ],
          ),
          bottomNavigationBar: Material(
            color: const Color(0xFFF2F2F2),
            child: TabBar(
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                labelColor: const Color(0xFF008FAE),
                tabs: <Widget>[
                  const Tab(
                    icon: Icon(
                      Icons.home,
                      size: 28,
                    ),
                  ),
                  const Tab(
                    icon: Icon(
                      Icons.add_to_photos_rounded,
                      size: 28,
                    ),
                  ),
                  Tab(
                    icon: Badge(
                      showBadge: false,
                      child: const Icon(
                        Icons.notifications_on_outlined,
                        size: 28,
                      ),
                    ),
                  ),
                  const Tab(
                    icon: Icon(
                      Icons.settings,
                      size: 28,
                    ),
                  ),
                ]),
          ),
        );
      }),
    );
  }
}
