import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/pages/add_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF008FAE),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProfilePage()));
          }, icon: const Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Material(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 30),
                          child: Container(
                            height: 300,
                            width: 250,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Image.network(
                                  'https://gust-production.s3.amazonaws.com/uploads/'
                                      'startup/logo_image/56445/'
                                      'Flutter_app_icon_whtbg.jpg',
                                fit: BoxFit.cover,
                              ),
                          ),
                        ),
                        const Text(
                          'Arshad Sanin P V',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Flutter Developer',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.linkedin,
                                color: Colors.black,
                                size: 26.0,
                              ),
                              FaIcon(
                                FontAwesomeIcons.instagram,
                                color: Colors.black,
                                size: 26.0,
                              ),
                              FaIcon(
                                FontAwesomeIcons.twitter,
                                color: Colors.black,
                                size: 26.0,
                              ),
                              FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Colors.black,
                                size: 26.0,
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Skills :',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            widgets.skillText(text: 'HTML'),
                            widgets.skillText(text: 'CSS'),
                            widgets.skillText(text: 'FLUTTER'),
                            widgets.skillText(text: 'JAVASCRIPT'),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            widgets.skillText(text: 'DART'),
                            widgets.skillText(text: 'GIT'),
                            widgets.skillText(text: 'ANDROID'),
                            widgets.skillText(text: 'IOS'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Details :',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                ),
              ),
              const SizedBox(height: 15,),
              Row(
                children: const [
                  Icon(Icons.location_on_outlined,color: Colors.black,),
                  Text('Location\t: '),
                  Text('Kerala, India'),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: const [
                  Icon(Icons.alternate_email,color: Colors.black,),
                  Text('Email\t: '),
                  Text('arshadzanin786@gmail.com'),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: const [
                  Icon(Icons.phone,color: Colors.black,),
                  Text('Phone\t: '),
                  Text('9746802988'),
                ],
              ),
              const SizedBox(height: 20,),
              const Text(
                'Experience :',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 15,),
              const Text(
                '2020 - 21',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Flutter Developer',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'In publishing and graphic design,'
                    ' Lorem ipsum is a placeholder'
                    ' text commonly used to demonstrate'
                    ' the visual form of a document or'
                    ' a typeface without relying on'
                    ' meaningful content.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                textAlign: TextAlign.justify,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
