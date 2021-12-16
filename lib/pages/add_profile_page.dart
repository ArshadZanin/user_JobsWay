import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/image_pick/utils.dart';
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
  
  ///assign controllers
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final skillsController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final experienceController = TextEditingController();
  final linkedInController = TextEditingController();
  final instagramController = TextEditingController();
  final twitterController = TextEditingController();
  final facebookController = TextEditingController();

  @override
  initState() {
    super.initState();
    retrieveData().whenComplete(() async {
      Directory tempDir = await getTemporaryDirectory();
      var tempPath = tempDir.path;
      // await File('$tempPath/profile.png').delete();
      File file = File('$tempPath/profile${widgets.i}.png');
      await file.writeAsBytes(bytesImage!.buffer.asUint8List(bytesImage!.offsetInBytes, bytesImage!.lengthInBytes));
      image = file;
      setState(() {
      });
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
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back)),
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
                      var value = base64Encode(image!.readAsBytesSync());
                      initializePreference(image: value);
                      setState(() {
                      });
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
                        child: image == null ?
                        Container()
                            : Image.file(image!),
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
                      textController: firstNameController
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: widgets.textFieldGrey(
                      label: 'Second Name',
                      textController: secondNameController
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'Job Title',
                  textController: jobTitleController
              ),
              const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'Skills',
                  textController: skillsController
              ),
              const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'Location',
                  textController: locationController
              ),const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'Email',
                  textController: emailController
              ),const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'Phone',
                  textController: phoneController
              ),const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'Experience',
                  textController: experienceController
              ),const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'LinkedIn Link',
                  textController: linkedInController
              ),const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'Instagram Link',
                  textController: instagramController
              ),const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'Twitter Link',
                  textController: twitterController
              ),const SizedBox(height: 10,),
              widgets.textFieldGrey(
                  label: 'Facebook Link',
                  textController: facebookController
              ),const SizedBox(height: 10,),
              InkWell(
                child: widgets.textFieldGrey(
                    label: 'Upload Resume',
                ),
              ),
              const SizedBox(height: 15,),
              Center(child: widgets.textColorButton(text: 'Submit', onPress: (){
                Navigator.pop(context);
              })),
              const SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> cropSquareImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );

  Future<void> initializePreference({
    required String image,
  }) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("image", image);
  }

  Future<void> retrieveData() async{
    final preferences = await SharedPreferences.getInstance();
    String? result = preferences.getString("image");
    bytesImage = base64Decode(result!);
  }
}
