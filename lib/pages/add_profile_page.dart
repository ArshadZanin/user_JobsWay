import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/image_pick/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({Key? key}) : super(key: key);

  @override
  _AddProfilePageState createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final widgets = Get.put(WidgetController());

  File? image;
  Uint8List? bytesImage;
  bool showImage = false;

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

  ///assign controllers
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final skillsController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final experienceFromController = TextEditingController();
  final experienceToController = TextEditingController();
  final experienceJobController = TextEditingController();
  final experienceAboutController = TextEditingController();
  final linkedInController = TextEditingController();
  final instagramController = TextEditingController();
  final twitterController = TextEditingController();
  final facebookController = TextEditingController();
  final resumeController = TextEditingController();

  @override
  initState() {
    super.initState();
    retrieveData().whenComplete(() async {

      if(bytesImage != []){
        showImage = true;
        Directory tempDir = await getTemporaryDirectory();
        var tempPath = tempDir.path;
        // await File('$tempPath/profile.png').delete();
        File file = File('$tempPath/profile${widgets.i}.png');
        await file.writeAsBytes(bytesImage!.buffer
            .asUint8List(bytesImage!.offsetInBytes, bytesImage!.lengthInBytes));
        image = file;
      }else{
        showImage = false;
      }

      if(secondName.isEmpty){
        List<String> name = firstName.split(' ');
        firstName = name[0];
        secondName = name[1];
      }


      firstNameController.text = firstName;
      secondNameController.text = secondName;
      jobTitleController.text = jobTitle;
      locationController.text = location;
      emailController.text = email;
      phoneController.text = phone;
      experienceFromController.text = '';
      experienceToController.text = '';
      experienceJobController.text = '';
      experienceAboutController.text = '';
      linkedInController.text = linkedin;
      instagramController.text = instagram;
      twitterController.text = twitter;
      facebookController.text = facebook;
      setState(() {});
      widgets.increment();
    });
  }

  Future<void> updateUser() async {

    final preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString("id");

    String fileExtension =
        image!.path.split('/').last.split('.').last;

    final bytes = await image!.readAsBytes();
    var value = base64.encode(bytes);

    final jsonMap = {
      "userDetails" : {
        "firstName" : firstName,
        "lastName" : secondName,
        "designation" : jobTitle,
        "instagram" : instagram,
        "twitter" : twitter,
        "facebook" : facebook,
        "linkedIn" : linkedin,
        "skills" : skills,
        "location" : location ,
        "phone" : phone,
        "portfolio" : "https://www.nihal-a.github.io",
        "experience" : experience
      },
      "image": """data:image/$fileExtension;base64,$value"""
    };
    String jsonData = jsonEncode(jsonMap);

    print(jsonData);

    try{

      String apiUrl =
          'https://jobsway-user.herokuapp.com/api/v1/user/edit-profile/$id';
      // const String apiUrl = 'https://reqres.in/api/login';
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonData,
        headers: {"Content-Type": "application/json"},
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final String responseString = response.body;
        // return userModelOtpFromJson(responseString);
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}',textAlign: TextAlign.center,),
          ));
        }
        // return null;
      }
    }on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check network connection',textAlign: TextAlign.center,),
      ));
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            color: const Color(0xFF008FAE),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () async {
                      image = (await Utils.pickImage(
                        cropImage: cropSquareImage,
                      ))!;
                      if(image != null){
                        showImage = true;
                      }

                      setState(() {});
                    },
                    child: Container(
                      height: 300,
                      width: 225,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: image != null ? Image.file(image!): Container(),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: widgets.textFieldGrey(
                        label: 'First Name',
                        textController: firstNameController),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: widgets.textFieldGrey(
                        label: 'Second Name',
                        textController: secondNameController),
                  ),
                ],
              ),

              widgets.textFieldGrey(
                  label: 'Job Title', textController: jobTitleController),

              Row(
                children: [
                  Expanded(
                    child: widgets.textFieldGrey(
                        label: 'Skills', textController: skillsController),
                  ),
                  IconButton(onPressed: () {
                    if(skillsController.text != ''){
                      skills.add(skillsController.text);
                    }
                    skillsController.text = '';
                    setState(() {});
                  }, icon: const Icon(Icons.add),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100,
                        childAspectRatio: 4 / 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemCount: skills.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onLongPress: (){
                          skills.removeAt(index);
                          setState(() {});
                        },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Center(
                                child: Text(skills[index]),
                            ),
                          ),
                      );
                    }),
              ),

              widgets.textFieldGrey(
                  label: 'Location', textController: locationController),

              widgets.textFieldGrey(
                  label: 'Email', textController: emailController),

              widgets.textFieldGrey(
                  label: 'Phone', textController: phoneController),


              widgets.textWidget(text: 'Experience',size: 15,bold: true),
              Row(
                children: [
                  Expanded(
                    child: widgets.textFieldGrey(
                        label: 'From', textController: experienceFromController),
                  ),
                  Expanded(
                    child: widgets.textFieldGrey(
                        label: 'To', textController: experienceToController),
                  ),
                ],
              ),
              widgets.textFieldGrey(
                  label: 'Job Title', textController: experienceJobController),
              widgets.textFieldGrey(
                  label: 'About Job',
                textController: experienceAboutController,
                maxLines: 5
              ),
              const SizedBox(height: 15,),
              widgets.textColorButton(
                text: 'Add Experience',
                onPress: (){
                  var from = experienceFromController.text.trim();
                  var to = experienceToController.text.trim();
                  var job = experienceJobController.text;
                  var about = experienceAboutController.text;
                  experienceFromController.text = '';
                  experienceToController.text = '';
                  experienceJobController.text = '';
                  experienceAboutController.text = '';
                  if(from != '' && to != '' && job != ''){
                    experience.add({'yearFrom':from,'yearTo':to, 'positionTitle':job,'desc':about});
                    setState(() {
                    });
                    // print(experience['year']);
                  }
                },
              ),
              const SizedBox(height: 15,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experience.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onLongPress: (){
                        experience.removeAt(index);
                        setState(() {});
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              widgets.textWidget(text: '${experience[index]['yearFrom']}-${experience[index]['yearTo']}',size: 15,bold: true),
                              widgets.textWidget(text: experience[index]['positionTitle']!,size: 15,bold: true),
                              widgets.textWidget(text: experience[index]['desc']!,size: 15,bold: true),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
              ),

              widgets.textFieldGrey(
                  label: 'LinkedIn Link', textController: linkedInController),

              widgets.textFieldGrey(
                  label: 'Instagram Link', textController: instagramController),

              widgets.textFieldGrey(
                  label: 'Twitter Link', textController: twitterController),

              widgets.textFieldGrey(
                  label: 'Facebook Link', textController: facebookController),

              Row(
                children: [
                  Expanded(
                    child: widgets.textFieldGrey(
                      textController: resumeController,
                      readOnly: true,
                      label: 'Upload Resume',
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.upload),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if(result == null) return;
                      ///open this file
                      final file = result.files.first;
                      // final newFile = await saveFilePermanently(file);


                      setState(() {
                        resumeController.text = file.name;
                      });
                      print(file.name);
                    },),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                  child: widgets.textColorButton(
                      text: 'Submit',
                      onPress: () async {

                        var from = experienceFromController.text.trim();
                        var to = experienceToController.text.trim();
                        var job = experienceJobController.text;
                        var about = experienceAboutController.text;
                        experienceFromController.text = '';
                        experienceToController.text = '';
                        experienceJobController.text = '';
                        experienceAboutController.text = '';
                        if(from != '' && to != '' && job != ''){
                          experience.add({'yearFrom':from,'yearTo':to, 'positionTitle':job,'desc':about});
                          setState(() {
                          });
                        }

                        var value = '';
                        if(image != null){
                          value = base64Encode(image!.readAsBytesSync());
                        }
                        firstName = firstNameController.text;
                        secondName = secondNameController.text;
                        jobTitle = jobTitleController.text;
                        location = locationController.text;
                        email = emailController.text;
                        phone = phoneController.text;
                        // experienceYear = experienceYearController.text;
                        experienceJob = experienceJobController.text;
                        experienceDescription = experienceAboutController.text;
                        linkedin = linkedInController.text;
                        instagram = instagramController.text;
                        twitter = twitterController.text;
                        facebook = facebookController.text;
                        if(skillsController.text != ''){
                          skills.add(skillsController.text);
                        }

                        initializePreference(image: value);
                        await updateUser();
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      })),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void openFile(PlatformFile file) async {
  //   OpenFile.open(file.path);
  //
  //   final newFile = await saveFilePermanently(file);
  // }

  // Future<File> saveFilePermanently(PlatformFile file) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final newFile = File('${appStorage.path}/${file.name}');
  //   return File(file.path!).copy(newFile.path);
  // }

  Future<File?> cropSquareImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );

  Future<void> initializePreference({
    required String image,
  }) async {
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
    await preferences.setStringList("skillList", skills);
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
    var experienceList = jsonDecode(experienceGet!);
    for( var x in experienceList){
      experience.add({'yearFrom':x['yearFrom'],'yearTo':x['yearTo'],'positionTitle':x['positionTitle'],'desc':x['desc']});
    }
    // experience = experienceList.toList() ?? [];


    String? linkedinGet = preferences.getString("linkedin");
    linkedin = linkedinGet ?? '';

    String? instagramGet = preferences.getString("instagram");
    instagram = instagramGet ?? '';

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
  }

}
