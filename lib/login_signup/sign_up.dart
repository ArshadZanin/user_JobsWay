import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/api/google_signin_api.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/log_in.dart';
import 'package:get/get.dart';
import 'package:jobs_way/login_signup/otp/otp_page.dart';
import 'package:jobs_way/model/google_signup_model.dart';
import 'package:jobs_way/model/signup_model.dart';
import 'package:jobs_way/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  UserModel? user;

  final widgets = Get.put(WidgetController());

  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();

  Future<UserModel?> createUser({
  required String firstName,
  required String secondName,
  required String password,
  required String phone,
  required String email,
  }) async {
    const String apiUrl = 'https://jobsway-user.herokuapp.com/api/v1/user/signup';
    final response = await http.post(Uri.parse(apiUrl), body:{
      "firstName": firstName,
      "lastName": secondName,
      "password": password,
      "phone": phone,
      "email": email
    });

    if(response.statusCode == 200){
      final String responseString = response.body;

      return userModelFromJson(responseString);
    }else{
      return null;
    }

  }

  @Deprecated('message')
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: widgets.headingTexts(
                          blackText: 'Welcome to ', colorText: 'JobsWay.'),
                    ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: widgets.textFieldGrey(
                                        label: 'First Name',
                                        textController: firstNameController,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: widgets.textFieldGrey(
                                        label: 'Second Name',
                                        textController: secondNameController,
                                      ),
                                    ),
                                  ],
                                ),
                                widgets.textFieldGrey(
                                  label: 'Email',
                                  textController: emailController,
                                ),
                                widgets.textFieldGrey(
                                  label: 'Phone',
                                  textController: phoneController,
                                ),
                                widgets.textFieldGrey(
                                  label: 'Password',
                                  textController: passwordController,
                                ),
                              ],
                            ),
                          ),
                          // widgets.textFieldGrey(
                          //   label: 'Code',
                          //   textController: codeController,
                          // ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    widgets.textColorButton(
                                        text: 'Sign Up',
                                        onPress: () async {

                                          final firstName = firstNameController.text;
                                          final secondName = secondNameController.text;
                                          final password = passwordController.text;
                                          final phone = phoneController.text;
                                          final email = emailController.text;

                                          user = await createUser(
                                              firstName: firstName,
                                              secondName: secondName,
                                              password: password,
                                              phone: phone,
                                              email: email);

                                          if(user != null){
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => OtpPage(user: user)));
                                          }
                                        }),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Or',
                                      style: GoogleFonts.poppins(color: Colors.black38),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
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
                                          width: 180,
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
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    widgets.buttonWithText(
                                      text: "Already on JobsWay?",
                                      buttonText: "Sign In",
                                      onPress: () {
                                        debugPrint("Sign in");
                                        Navigator.pushReplacement(
                                            context, MaterialPageRoute(builder: (_) => LogIn()));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn(BuildContext context) async {
    final user = await GoogleSignInApi.login();



    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sign up Failed'),
      ));
    } else {
      var details = await createUserWithGoogle(
          email: user.email,
        id: user.id,
        name: user.displayName!,
      );

      if(details!.token != null){
        bool ban = details.user!.ban == false ? false : true;
        initializePreference(
          token: details.token!,
          name: details.user!.name!,
          ban: ban,
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
          content: Text('Sign up Failed'),
        ));
      }
    }
  }

  Future<GoogleUser?> createUserWithGoogle({
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
  }) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("name", name);
    await preferences.setString("email", email);
    await preferences.setString("id", id);
    await preferences.setString("password", password);
    await preferences.setString("token", token);
    await preferences.setBool("ban", ban);
  }

}
// {
//   "user":{
//     "_id":"61b96b20620ec1405b22c7b0",
//     "email":"arshadsanin@gmail.com",
// "password":"$2b$12$4xw9njb32UCB9bJf57LmwOfq6maT5UvW8tLfKgC2Pvm65Kc6SIth6",
// "name":"Alfiya Gaming",
// "ban":false
// },
// "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFyc2hhZHNhbmluQGdtYWlsLmNvbSIsImlkIjoiNjFiOTZiMjA2MjBlYzE0MDViMjJjN2IwIiwiaWF0IjoxNjM5NTQxNTg3LCJleHAiOjE2Mzk1NDUxODd9.JYyGrYW_j898RRioIqSWSp_jXW7-Ugv0s6fQjoDeekQ"
// }