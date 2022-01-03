import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/api/google_signin_api.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/login_signup/forgot_password/forgot_password.dart';
import 'package:jobs_way/login_signup/sign_up.dart';
import 'package:get/get.dart';
import 'package:jobs_way/model/google_signup_model.dart';
import 'package:jobs_way/model/otp_signup_model.dart';
import 'package:jobs_way/pages/main_pages/home_page.dart';
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
  bool _isObscurePassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  Future<UserModelOtp?> loginUser({
    required String password,
    required String phone,
  }) async {
    try {
      const String apiUrl =
          'https://jobsway-user.herokuapp.com/api/v1/user/signin';
      final response = await http.post(Uri.parse(apiUrl), body: {
        "phone": phone,
        "password": password,
      });

      if (response.statusCode == 200) {
        final String responseString = response.body;

        return userModelOtpFromJson(responseString);
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}',textAlign: TextAlign.center,),
          ));
        }
        return null;
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
                      blackText: 'Welcome to ', colorText: 'JobsWay.'),
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
                            keyboardType: TextInputType.number
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        widgets.textFieldGreyObscure(
                          label: 'Password',
                          textController: passwordController,
                          obscure: _isObscurePassword,
                          onPress: () {
                            _isObscurePassword ?
                            _isObscurePassword = false :
                            _isObscurePassword = true;
                            setState(() {

                            });
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ForgotPassword(),
                                    ),
                                  );
                                  debugPrint("Forgot Password");
                                },
                                child: const Text('Forgot Password'))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        widgets.textColorButtonCircle(
                            text: 'Sign In',
                            onPress: () async {

                              _isLoading = true;

                              setState(() {

                              });

                              if (emailOrUserNameController.text.length < 10) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('phone number is not correct!',textAlign: TextAlign.center,),
                                ));
                                _isLoading = false;
                                setState(() {

                                });
                              } else if (passwordController.text.length < 8) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('check your password',textAlign: TextAlign.center,),
                                ));
                                _isLoading = false;
                                setState(() {

                                });
                              } else {
                                var user = await loginUser(
                                    phone: emailOrUserNameController.text,
                                    password: passwordController.text);
                                if (user != null) {
                                  await initializePreference(
                                      name: user.user.name,
                                      password: user.user.password,
                                      ban: user.user.ban,
                                      id: user.user.id,
                                      token: user.token,
                                      email: user.user.email,
                                      phone: user.user.phone);

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HomePage()));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Sign in Failed',textAlign: TextAlign.center,),
                                  ));
                                  _isLoading = false;
                                  setState(() {

                                  });
                                }
                              }
                            }, isLoading: _isLoading),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Or',
                          style: GoogleFonts.poppins(color: Colors.black38),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        widgets.googleLoginButton(onPress: (){
                          _isGoogleLoading = true;
                          setState(() {});
                          signIn(context);
                        },
                          isLoading: _isGoogleLoading,),
                        // const SizedBox(height: 15,),
                        widgets.buttonWithText(
                          text: "New to JobsWay?",
                          buttonText: "Sign Up",
                          onPress: () {
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

    try{
      final user = await GoogleSignInApi.login();

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sign in Failed',textAlign: TextAlign.center,),
        ));
        _isGoogleLoading = false;
        setState(() {});
      } else {
        var details = await logInUserWithGoogle(
          email: user.email,
          id: user.id,
          name: user.displayName!,
        );

        if (details!.token != null) {
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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sign in Failed',textAlign: TextAlign.center,),
          ));
          _isGoogleLoading = false;
          setState(() {});
        }
      }
    }on PlatformException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code,textAlign: TextAlign.center,),
      ));
      _isGoogleLoading = false;
      setState(() {});
    }on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check network connection',textAlign: TextAlign.center,),
      ));
      _isGoogleLoading = false;
      setState(() {});
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      _isGoogleLoading = false;
      setState(() {});
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      _isGoogleLoading = false;
      setState(() {});
    }
  }

  Future<GoogleUser?> logInUserWithGoogle({
    required String name,
    required String id,
    required String email,
  }) async {
    try{
      const String apiUrl =
          'https://jobsway-user.herokuapp.com/api/v1/user/googlesign';
      List<String> names = name.split(' ');
      final response = await http.post(Uri.parse(apiUrl), body: {
        "email": email,
        "firstName": names[0],
        "lastName": names[1],
        "password": id
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> responseString = jsonDecode(response.body);
        debugPrint('$responseString');
        return GoogleUser.fromJson(responseString);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sign in Failed'),
        ));
        _isGoogleLoading = false;
        setState(() {});
        return null;
      }
    }on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check network connection',textAlign: TextAlign.center,),
      ));
      _isGoogleLoading = false;
      setState(() {});
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      _isGoogleLoading = false;
      setState(() {});
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      _isGoogleLoading = false;
      setState(() {});
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
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("login", 'login');
    await preferences.setString("firstName", name);
    await preferences.setString("email", email);
    await preferences.setString("phone", phone);
    await preferences.setString("id", id);
    await preferences.setString("password", password);
    await preferences.setString("token", token);
    await preferences.setBool("ban", ban);
  }
}
