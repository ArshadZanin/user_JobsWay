import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/model/otp_signup_model.dart';
import 'package:jobs_way/pages/featured_jobs.dart';
import 'package:jobs_way/pages/home_screen_page.dart';
import 'package:jobs_way/pages/my_jobs_page.dart';
import 'package:jobs_way/pages/settings_page.dart';
import 'package:badges/badges.dart';


class HomePage extends StatefulWidget {
  HomePage({userDetails, Key? key}) : super(key: key);
  UserModelOtp? userDetails;

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
                    child:const Icon(
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
      ),
    );
  }
}
