import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';

class BuildResume extends StatefulWidget {
  const BuildResume({Key? key}) : super(key: key);

  @override
  _BuildResumeState createState() => _BuildResumeState();
}

class _BuildResumeState extends State<BuildResume> {

  final widgets = Get.put(WidgetController());
  ///assign controllers
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final aboutController = TextEditingController();
  final educationController = TextEditingController();
  final skillsController = TextEditingController();
  final experienceYearController = TextEditingController();
  final experienceRoleController = TextEditingController();
  final experienceAboutController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final portfolioController = TextEditingController();
  final linkedinController = TextEditingController();
  final instagramController = TextEditingController();
  final facebookController = TextEditingController();
  final twitterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        centerTitle: true,
        title: Row(
          children: const [
            Text(
              'Build Your ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'JobsWay Resume',
              style: TextStyle(
                color: Color(0xFF008FAE),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              widgets.textFieldGrey(
                label: 'First Name',
                textController: firstNameController
              ),
              widgets.textFieldGrey(
                label: 'Second Name',
                textController: secondNameController
              ),
              widgets.textFieldGrey(
                label: 'Job Title',
                textController: jobTitleController
              ),
              widgets.textFieldGrey(
                label: 'About You',
                textController: aboutController
              ),
              const Text('Education',
                style: TextStyle(
                    color: Colors.grey
                ),),
              widgets.textFieldGrey(
                label: 'Education',
                textController: educationController
              ),
              const Text('Skills',
                style: TextStyle(
                    color: Colors.grey
                ),),
              widgets.textFieldGrey(
                label: 'Skills',
                textController: skillsController
              ),
              const Text('Experience',
              style: TextStyle(
                color: Colors.grey
              ),),
              Row(
                children: [
                  Expanded(
                    child: widgets.textFieldGrey(
                      label: 'Year',
                      textController: experienceYearController
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: widgets.textFieldGrey(
                        label: 'Your Role',
                        textController: experienceRoleController
                    ),
                  ),
                ],
              ),

              widgets.textFieldGrey(
                label: 'About',
                textController: experienceAboutController
              ),
              const Text('Contact Details',
                style: TextStyle(
                    color: Colors.grey
                ),),
              widgets.textFieldGrey(
                label: 'Phone',
                textController: phoneController
              ),
              widgets.textFieldGrey(
                label: 'Email',
                textController: emailController
              ),
              widgets.textFieldGrey(
                label: 'Location',
                textController: locationController
              ),
              widgets.textFieldGrey(
                label: 'Portfolio Link',
                textController: portfolioController
              ),
              widgets.textFieldGrey(
                label: 'LinkedIn',
                textController: linkedinController
              ),
              widgets.textFieldGrey(
                label: 'Instagram',
                textController: instagramController
              ),
              widgets.textFieldGrey(
                label: 'Facebook',
                textController: facebookController
              ),
              widgets.textFieldGrey(
                label: 'Twitter',
                textController: twitterController
              ),
              Row(
                children: const [
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.check_box),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                        'I hereby declare that the information given in this'
                            ' application is true and correct to the best of'
                            ' my knowledge and belief. In case any information'
                            ' given in this application proves to be false or'
                            ' incorrect, I shall be responsible for the consequences.'
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: widgets.textColorButton(text: 'Create my resume', onPress: (){}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
