import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/sign_up.dart';
import 'package:jobs_way/pages/featured_jobs.dart';
import 'package:jobs_way/pages/home_screen_page.dart';
import 'package:jobs_way/pages/my_jobs_page.dart';
import 'package:jobs_way/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: widgets.appbarCustom(context),
        body: TabBarView(
          children: <Widget>[
            const HomeScreenPage(),
            FeaturedJobsPage(),
            const MyJobsPage(),
            const SettingsPage(),
          ],
        ),
        bottomNavigationBar: const Material(
          color: Color(0xFFF2F2F2),
          child: TabBar(
            unselectedLabelColor: Colors.grey,
              labelColor: Color(0xFF008FAE),
              tabs: <Widget>[
            Tab(icon: Icon(Icons.home,size: 28,), child: Text('Home',style: TextStyle(fontSize: 12),)),
            Tab(icon: Icon(Icons.add_to_photos_rounded,size: 28,), child: Text('My Jobs',style: TextStyle(fontSize: 12),)),
            Tab(icon: Icon(Icons.alarm,size: 28,), child: Text('Notifications',style: TextStyle(fontSize: 12),)),
            Tab(icon: Icon(Icons.settings,size: 28,), child: Text('Settings',style: TextStyle(fontSize: 12),)),
          ]),
        ),
      ),
    );
  }
}