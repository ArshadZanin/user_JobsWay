import 'package:flutter/material.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/sign_up.dart';
import 'package:get/get.dart';
import 'package:jobs_way/pages/featured_jobs.dart';
import 'package:jobs_way/pages/home_page.dart';


class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);

  final widgets = Get.put(WidgetController());
  final emailOrUserNameController = TextEditingController();
  final passwordController = TextEditingController();

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
                  widgets.textFieldGrey(
                    label: 'Email or Username',
                    textController: emailOrUserNameController,
                  ),
                  const SizedBox(height: 10,),
                  widgets.textFieldGrey(
                    label: 'Password',
                    textController: passwordController,
                  ),
                  const SizedBox(height: 25,),
                  widgets.textColorButton(text: 'Sign In', onPress: (){
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
                        'Sign In with Google',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  widgets.buttonWithText(
                      text: "New to JobsWay?",
                      buttonText: "Sign Up",
                      onPress: (){
                        debugPrint("Sign Up");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SignUp()));
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
