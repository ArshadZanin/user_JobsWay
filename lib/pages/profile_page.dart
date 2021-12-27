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
  List imageBytes = [];
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

  bool linkedinBool = false;
  bool instagramBool = false;
  bool twitterBool = false;
  bool facebookBool = false;

  @override
  initState() {
    super.initState();
    retrieveData().whenComplete(() {

      if(bytesImage != null){
        imageBytes = bytesImage!.toList();
      }else{
        imageBytes = [];
      }

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
            retrieveData().whenComplete(() {
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
          padding: const EdgeInsets.all(18.0),
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
                                child: imageBytes.isNotEmpty ?
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
                                maxCrossAxisExtent: 100,
                                childAspectRatio: 2,
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
                  const Icon(Icons.location_on_outlined,color: Colors.black,size: 24,),
                  const Text('\t\tLocation\t\t\t: ',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  Expanded(child: Text(location,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const Icon(Icons.alternate_email_outlined,color: Colors.black,size: 22,),
                  const Text(
                      '\t\tEmail\t\t\t\t\t\t\t\t\t\t: ',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                  ),
                  Expanded(child: Text(email,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const Icon(Icons.phone_outlined,color: Colors.black,size: 22,),
                  const Text('\t\tPhone\t\t\t\t\t\t\t\t: ',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  Expanded(child: Text(phone,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experience.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Column(
                      children: [
                        Text(
                          '${experience[index]['yearFrom']}-${experience[index]['yearTo']}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          experience[index]['positionTitle']!,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            experience[index]['desc']!,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.justify,

                          ),
                        ),
                      ],
                    ),),
                  );
                },
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
    if(result != null){
      bytesImage = base64Decode(result);
    }

    String? firstNameGet = preferences.getString("firstName");
    firstName = firstNameGet ?? '';

    String? secondNameGet = preferences.getString("secondName");
    secondName = secondNameGet ?? '';

    String? jobTitleGet = preferences.getString("jobTitle");
    jobTitle = jobTitleGet ?? '';

    String? locationGet = preferences.getString("location");
    location = locationGet ?? '';

    String? emailGet = preferences.getString("email");
    email = emailGet ?? '';

    String? phoneGet = preferences.getString("phone");
    phone = phoneGet ?? '';

    String? experienceGet = preferences.getString("experience");
    print(experienceGet);
    var experienceList = jsonDecode(experienceGet ?? '[]');
    experience.clear();
    for( var x in experienceList){
      experience.add({'yearFrom':x['yearFrom'],'yearTo':x['yearTo'],'positionTitle':x['positionTitle'],'desc':x['desc']});
    }

    String? linkedinGet = preferences.getString("linkedin");
    linkedin = linkedinGet ?? '';

    String? instagramGet = preferences.getString("instagram");
    instagram = instagramGet ?? '{}';

    String? twitterGet = preferences.getString("twitter");
    twitter = twitterGet ?? '';

    String? facebookGet = preferences.getString("facebook");
    facebook = facebookGet ?? '';

    List<String>? listSkills = preferences.getStringList("skillList");
    if(listSkills != null){
      skills = listSkills;
    }

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
