import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({Key? key}) : super(key: key);

  @override
  _AddProfilePageState createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {

  final widgets = Get.put(WidgetController());
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xFF008FAE),
          ),
        ),
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
                  child: Container(
                    height: 300,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(30),
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
              Center(child: widgets.textColorButton(text: 'Submit', onPress: (){})),
              const SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}
