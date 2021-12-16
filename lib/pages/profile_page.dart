import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/pages/add_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final widgets = Get.put(WidgetController());
  Uint8List? bytesImage;

  @override
  initState() {
    super.initState();
    retrieveData().whenComplete(() {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bytesImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: const Color(0xFF008FAE),
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
                            width: 225,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: bytesImage != null ?
                                Image.memory(
                                  bytesImage!,
                                  fit: BoxFit.cover,
                                ):Container(),
                              ),
                          ),
                        ),
                        Text(
                          'Arshad Sanin P V',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Flutter Developer',
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 25),
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
                        Text(
                          'Skills :',
                          style: GoogleFonts.poppins(
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
              Text(
                'Details :',
                style: GoogleFonts.poppins(
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
              Text(
                'Experience :',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                '2020 - 21',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Flutter Developer',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'In publishing and graphic design,'
                    ' Lorem ipsum is a placeholder'
                    ' text commonly used to demonstrate'
                    ' the visual form of a document or'
                    ' a typeface without relying on'
                    ' meaningful content.',
                style: GoogleFonts.poppins(
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

  Future<void> retrieveData() async{
    final preferences = await SharedPreferences.getInstance();
    String? result = preferences.getString("image");
    bytesImage = base64Decode(result!);
  }

}
