import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/otp/otp_page.dart';

final widgets = Get.put(WidgetController());

class OtpEmail extends StatelessWidget {
  OtpEmail({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                widgets.headingTexts(blackText: 'Enter the Registered Email'),
                const Text(
                    'JobsWay will send a One time password to the registered email '),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: widgets.textFieldGrey(
                    label: 'Email',
                    textController: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: widgets.textColorButton(
                    text: 'Submit',
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OtpPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

