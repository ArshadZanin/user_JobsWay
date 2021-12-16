import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobs_way/login_signup/sign_up.dart';
import 'package:jobs_way/pages/add_profile_page.dart';
import 'package:jobs_way/pages/build_resume.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddProfilePage(),
                    ),
                  );
                },
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.edit),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BuildResume(),
                    ),
                  );
                },
                title: const Text('Build Resume'),
                trailing: const Icon(Icons.three_p_outlined),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignUp(),
                    ),
                  );
                },
                title: const Text('Log out'),
                trailing: const Icon(Icons.logout),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {

                },
                title: const Text('Upgrade Premium'),
                trailing: const FaIcon(
                  FontAwesomeIcons.crown,
                  color: Colors.amber,
                  size: 26.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
