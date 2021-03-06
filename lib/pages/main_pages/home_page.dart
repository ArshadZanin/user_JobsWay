import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/api_controller.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/log_in.dart';
import 'package:jobs_way/model/otp_signup_model.dart';
import 'package:jobs_way/pages/main_pages/all_jobs_page.dart';
import 'package:jobs_way/pages/main_pages/featured_jobs.dart';
import 'package:jobs_way/pages/main_pages/home_screen_page.dart';
import 'package:jobs_way/pages/other_pages/assigned_tasks.dart';
import 'package:jobs_way/pages/main_pages/settings_page.dart';
import 'package:badges/badges.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  HomePage({userDetails, Key? key}) : super(key: key);
  UserModelOtp? userDetails;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final widgets = Get.put(WidgetController());
  final apis = Get.put(ApiController());


  ///profile datas
  String firstName = '';
  String secondName = '';
  String jobTitle = '';
  List<String> skills = [];
  String location = '';
  String email = '';
  String phone = '';
  List<Map<String, String>> experience = [];
  String experienceYear = '';
  String experienceJob = '';
  String experienceDescription = '';
  String linkedin = '';
  String instagram = '';
  String twitter = '';
  String facebook = '';
  String portfolio = '';

  Future<void> fetchAndUpdate() async {
    var user = await apis.fetchUser(context);
    if(user != null){
      var names = user.name!.split(' ');
      firstName = names[0];
      secondName = names[1];
      jobTitle = user.designation ?? '';
      location = user.location ?? '';
      email = user.email ?? '';
      phone = user.phone ?? '';

      if(jobTitle == '' || location == '' || email == '' || phone == ''){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please update your profile!',textAlign: TextAlign.center,),
        ));
      }

      if(user.skills!.isNotEmpty){
        for (var x in user.skills!) {
          skills.add(x);
        }
      }
      print(skills);
      if(user.experience != null){
        for(var x in user.experience!){
          experience.add({"yearFrom" : x.yearFrom!,"yearTo" : x.yearTo!, "positionTitle":x.positionTitle!,"desc":x.desc!});
        }
      }
      linkedin = user.linkedIn ?? '';
      instagram = user.instagram ?? '';
      twitter = user.twitter ?? '';
      facebook = user.facebook ?? '';
      portfolio = user.portfolio ?? '';

      var response = await http.get(Uri.parse(user.imgUrl!));
      var value = base64Encode(response.bodyBytes);
      initializePreference(image: value);
    }


  }


  @override
  initState(){
    super.initState();
    fetchAndUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Obx(() {
        return Scaffold(
          appBar: widgets.appbarCustom(context),
          body: const TabBarView(
            children: <Widget>[
              HomeScreenPage(),
              AllJobsPage(),
              AssignedTaskPage(),
              SettingsPage(),
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

  Future<void> initializePreference({
    required String image,
  }) async {
    print('data saved');
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("image", image);
    await preferences.setString("firstName", firstName);
    await preferences.setString("secondName", secondName);
    await preferences.setString("jobTitle", jobTitle);
    await preferences.setString("location", location);
    await preferences.setString("email", email);
    await preferences.setString("phone", phone);
    var experienceList = jsonEncode(experience);
    await preferences.setString("experience", experienceList);
    await preferences.setString("linkedin", linkedin);
    await preferences.setString("instagram", instagram);
    await preferences.setString("twitter", twitter);
    await preferences.setString("facebook", facebook);
    await preferences.setString("portfolio", facebook);
    await preferences.setStringList("skillList", skills);
  }

}
