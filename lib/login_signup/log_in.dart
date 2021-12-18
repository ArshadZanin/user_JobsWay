import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/api/google_signin_api.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/sign_up.dart';
import 'package:get/get.dart';
import 'package:jobs_way/model/google_signup_model.dart';
import 'package:jobs_way/model/otp_signup_model.dart';
import 'package:jobs_way/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final widgets = Get.put(WidgetController());
  final emailOrUserNameController = TextEditingController();
  final passwordController = TextEditingController();


  Future<UserModelOtp?> loginUser({
    required String password,
    required String phone,
  }) async {
    const String apiUrl = 'https://jobsway-user.herokuapp.com/api/v1/user/signin';
    final response = await http.post(Uri.parse(apiUrl), body:{
      "phone": phone,
      "password": password,
    });

    if(response.statusCode == 200){
      final String responseString = response.body;

      return userModelOtpFromJson(responseString);
    }else{
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: widgets.headingTexts(
                      blackText: 'Welcome to ',
                    colorText: 'JobsWay.'
                  ),
                ),
                // const SizedBox(height: 50,),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widgets.textFieldGrey(
                          label: 'Phone Number',
                          textController: emailOrUserNameController,
                        ),
                        const SizedBox(height: 10,),
                        widgets.textFieldGrey(
                          label: 'Password',
                          textController: passwordController,
                        ),
                        const SizedBox(height: 25,),
                        widgets.textColorButton(text: 'Sign In', onPress: () async {

                          if(emailOrUserNameController.text.length < 10){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('phone number is not correct!'),
                            ));
                          }else if(passwordController.text.length < 8){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('check your password'),
                            ));
                          }else {
                            var user = await loginUser(
                                phone: emailOrUserNameController.text,
                                password: passwordController.text
                            );
                            if (user!.user.id != null) {
                              print(user.user.name);
                              print(user.user.password);
                              print(user.user.id);
                              print(user.user.email);
                              print(user.user.phone);
                              await initializePreference(
                                name: user.user.name,
                                password: user.user.password,
                                ban: user.user.ban,
                                id: user.user.id,
                                token: user.token,
                                email: user.user.email,
                                phone: user.user.phone
                              );

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                      builder: (_) => HomePage()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Sign in Failed'),
                                  ));
                            }
                          }
                        }),
                        const SizedBox(height: 15,),
                        Text('Or',style: GoogleFonts.poppins(color: Colors.black38),),
                        const SizedBox(height: 15,),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF397AF3)),
                          ),
                          onPressed: () {
                            signIn(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: SizedBox(
                              width: 190,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.white,
                                    child: Image.asset('assets/images/google_icon.png'),
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(
                                    'Sign Up with Google',
                                    style: GoogleFonts.poppins(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 15,),
                        widgets.buttonWithText(
                          text: "New to JobsWay?",
                          buttonText: "Sign Up",
                          onPress: (){
                            debugPrint("Sign Up");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUp()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn(BuildContext context) async {
    print('Started');
    final user = await GoogleSignInApi.login();
    print('user get');

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sign in Failed'),
      ));
    } else {
      var details = await logInUserWithGoogle(
        email: user.email,
        id: user.id,
        name: user.displayName!,
      );
      print('data send');


      if(details!.token != null){
       await initializePreference(
          token: details.token!,
          name: details.user!.name!,
          ban: details.user!.ban!,
          email: details.user!.email!,
          id: details.user!.id!,
          password: details.user!.password!,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sign in Failed'),
        ));
      }
    }
  }

  Future<GoogleUser?> logInUserWithGoogle({
    required String name,
    required String id,
    required String email,
  }) async {
    const String apiUrl = 'https://jobsway-user.herokuapp.com/api/v1/user/googlesign';
    List<String> names = name.split(' ');
    final response = await http.post(Uri.parse(apiUrl), body:{
      "email": email,
      "firstName": names[0],
      "lastName": names[1],
      "password": id
    });

    if(response.statusCode == 200){
      Map<String, dynamic> responseString = jsonDecode(response.body);
      debugPrint('$responseString');
      return GoogleUser.fromJson(responseString);
    }else{
      return null;
    }

  }

  Future<void> initializePreference({
    required String name,
    required String email,
    required String id,
    required String password,
    required String token,
    required bool ban,
    String phone = '',
  }) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("firstName", name);
    await preferences.setString("email", email);
    await preferences.setString("phone", phone);
    await preferences.setString("id", id);
    await preferences.setString("password", password);
    await preferences.setString("token", token);
    await preferences.setBool("ban", ban);
  }
}
