import 'dart:convert';
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
  ///profile datas
  String firstName = '';
  String secondName = '';
  String jobTitle = '';
  List<String> skills = [];
  String location = '';
  String email = '';
  String phone = '';
  String experienceYear = '';
  String experienceJob = '';
  String experienceDescription = '';
  String linkedin = '';
  String instagram = '';
  String twitter = '';
  String facebook = '';

  bool linkedinBool = false;
  bool instagramBool = false;
  bool twitterBool = false;
  bool facebookBool = false;

  @override
  initState() {
    super.initState();
    retrieveData().whenComplete(() {
      setState(() {
      });
    });

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
          IconButton(onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProfilePage()));
            await retrieveData().whenComplete(() {
              setState(() {
              });
            });
            Future.delayed(const Duration(milliseconds: 500),(){
              retrieveData();
              setState(() {

              });
            });

          }, icon: const Icon(Icons.edit)),
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
                          '$firstName $secondName',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          jobTitle,
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Visibility(
                                visible: linkedinBool,
                                child: const FaIcon(
                                  FontAwesomeIcons.linkedin,
                                  color: Colors.black,
                                  size: 26.0,
                                ),
                              ),
                              Visibility(
                                visible: instagramBool,
                                child: const FaIcon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.black,
                                  size: 26.0,
                                ),
                              ),
                              Visibility(
                                visible: twitterBool,
                                child: const FaIcon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.black,
                                  size: 26.0,
                                ),
                              ),
                              Visibility(
                                visible: facebookBool,
                                child: const FaIcon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.black,
                                  size: 26.0,
                                ),
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
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                            gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 120,
                                childAspectRatio: 4 / 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                            itemCount: skills.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return widgets.skillText(text: skills[index]);
                            }),
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
                children: [
                  const Icon(Icons.location_on_outlined,color: Colors.black,),
                  const Text('Location\t: '),
                  Text(location),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const Icon(Icons.alternate_email,color: Colors.black,),
                  const Text('Email\t: '),
                  Text(email),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const Icon(Icons.phone,color: Colors.black,),
                  const Text('Phone\t: '),
                  Text(phone),
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
                experienceYear,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                experienceJob,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                experienceDescription,
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

    String? firstNameGet = preferences.getString("firstName");
    firstName = firstNameGet!;

    if(firstNameGet == null){
      String? name = preferences.getString("name");
      firstName = name!;
    }

    String? secondNameGet = preferences.getString("secondName");
    secondName = secondNameGet!;

    String? jobTitleGet = preferences.getString("jobTitle");
    jobTitle = jobTitleGet!;

    String? locationGet = preferences.getString("location");
    location = locationGet!;

    String? emailGet = preferences.getString("email");
    email = emailGet!;

    String? phoneGet = preferences.getString("phone");
    phone = phoneGet!;

    String? experienceYearGet = preferences.getString("experienceYear");
    experienceYear = experienceYearGet!;

    String? experienceJobGet = preferences.getString("experienceJob");
    experienceJob = experienceJobGet!;

    String? experienceDescriptionGet = preferences.getString("experienceDescription");
    experienceDescription = experienceDescriptionGet!;

    String? linkedinGet = preferences.getString("linkedin");
    linkedin = linkedinGet!;

    String? instagramGet = preferences.getString("instagram");
    instagram = instagramGet!;

    String? twitterGet = preferences.getString("twitter");
    twitter = twitterGet!;

    String? facebookGet = preferences.getString("facebook");
    facebook = facebookGet!;

    List<String>? listSkills = preferences.getStringList("skillList");
    skills = listSkills!;

    setState(() {

    });

    if(linkedin != ''){
      linkedinBool = true;
    }else{
      linkedinBool = false;
    }

    if(instagram != ''){
      instagramBool = true;
    }else{
      instagramBool = false;
    }

    if(twitter != ''){
      twitterBool = true;
    }else{
      twitterBool = false;
    }

    if(facebook != ''){
      facebookBool = true;
    }else{
      facebookBool = false;
    }

    setState(() {

    });
  }

}
