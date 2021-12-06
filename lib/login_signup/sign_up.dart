import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/log_in.dart';
import 'package:get/get.dart';
import 'package:jobs_way/pages/featured_jobs.dart';
import 'package:jobs_way/pages/home_page.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final widgets = Get.put(WidgetController());

  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @Deprecated('message')
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widgets.headingTexts(
                      blackText: 'Welcome to ',
                    colorText: 'JobsWay.'
                  ),
                  const SizedBox(height: 50,),
                  Row(
                    children: [
                      Expanded(
                        child: widgets.textFieldGrey(
                          label: 'First Name',
                          textController: firstNameController,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: widgets.textFieldGrey(
                          label: 'Second Name',
                          textController: secondNameController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  widgets.textFieldGrey(
                    label: 'Email',
                    textController: emailController,
                  ),
                  const SizedBox(height: 10,),
                  widgets.textFieldGrey(
                    label: 'Password',
                    textController: passwordController,
                  ),
                  const SizedBox(height: 10,),
                  widgets.textFieldGrey(
                    label: 'Confirm Password',
                    textController: confirmPasswordController,
                  ),
                  const SizedBox(height: 25,),
                  widgets.textColorButton(text: 'Sign Up', onPress: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                  }),
                  const SizedBox(height: 15,),
                  const Text('Or',style: TextStyle(color: Colors.black38),),
                  const SizedBox(height: 15,),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF0060A5)),
                    ),
                    onPressed: () {  },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sign Up with Google',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  widgets.buttonWithText(
                      text: "Already on JobsWay?",
                      buttonText: "Sign In",
                      onPress: (){
                        debugPrint("Sign in");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LogIn()));
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
