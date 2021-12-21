import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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

  ///assign controllers
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final skillsController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final experienceYearController = TextEditingController();
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

      if(bytesImage != null){
        Directory tempDir = await getTemporaryDirectory();
        var tempPath = tempDir.path;
        // await File('$tempPath/profile.png').delete();
        File file = File('$tempPath/profile${widgets.i}.png');
        await file.writeAsBytes(bytesImage!.buffer
            .asUint8List(bytesImage!.offsetInBytes, bytesImage!.lengthInBytes));
        image = file;
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
      experienceYearController.text = experienceYear;
      experienceJobController.text = experienceJob;
      experienceAboutController.text = experienceDescription;
      linkedInController.text = linkedin;
      instagramController.text = instagram;
      twitterController.text = twitter;
      facebookController.text = facebook;
      setState(() {});
      widgets.increment();
    });
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
                        child: image == null ? Container() : Image.file(image!),
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
                              border: Border.all(
                              )
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

              widgets.textFieldGrey(
                  label: 'Experience Year', textController: experienceYearController),
              widgets.textFieldGrey(
                  label: 'Experienced Job Title', textController: experienceJobController),
              widgets.textFieldGrey(
                  label: 'About Job',
                textController: experienceAboutController,
                maxLines: 5
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
                      onPress: () {

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
                        experienceYear = experienceYearController.text;
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
    await preferences.setString("experienceYear", experienceYear);
    await preferences.setString("experienceJob", experienceJob);
    await preferences.setString("experienceDescription", experienceDescription);
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

    String? experienceYearGet = preferences.getString("experienceYear");
    experienceYear = experienceYearGet ?? '';

    String? experienceJobGet = preferences.getString("experienceJob");
    experienceJob = experienceJobGet ?? '';

    String? experienceDescriptionGet = preferences.getString("experienceDescription");
    experienceDescription = experienceDescriptionGet ?? '';

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
