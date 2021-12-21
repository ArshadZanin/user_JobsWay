import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/model/otp_signup_model.dart';
import 'package:jobs_way/model/signup_model.dart';
import 'package:jobs_way/pages/home_page.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class OtpPage extends StatefulWidget {
  OtpPage({this.user, Key? key}) : super(key: key);
  UserModel? user;

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  UserModelOtp? userDetails;
  String otpPin = '';
  final widgets = Get.put(WidgetController());
  final otpController = TextEditingController();
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;


  Future<UserModelOtp?> createUser({
    required String otp,
    required String firstName,
    required String secondName,
    required String password,
    required String phone,
    required String email,
  }) async {

    final jsonMap = {
      "otp" : otp,
      "userDetails" : {
        "firstName" : firstName,
        "lastName" : secondName,
        "password" : password,
        "phone" : phone,
        "email" : email
      }
    };
    String jsonData = jsonEncode(jsonMap);
    try{

      const String apiUrl =
          'https://jobsway-user.herokuapp.com/api/v1/user/verifyotp';
      // const String apiUrl = 'https://reqres.in/api/login';
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonData,
        headers: {"Content-Type": "application/json"},
      );

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: widgets.headingTexts(
                      blackText: 'Enter the ',
                      colorText: 'OTP',),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 28.0),
                  child: Text(
                      'JobsWay will send a One time password'),
                ),
                widgets.otpField(
                    context: context,
                    onCompleted: (value){
                      print(value);
                      otpPin = value;
                    }
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 28.0),
                //   child: OTPTextField(
                //     length: 6,
                //     width: MediaQuery.of(context).size.width,
                //     fieldWidth: 50,
                //     style: GoogleFonts.poppins(
                //         fontSize: 17
                //     ),
                //     textFieldAlignment: MainAxisAlignment.center,
                //     fieldStyle: FieldStyle.underline,
                //     onCompleted: (pin) async {
                //
                //       otpPin = pin;
                //
                //     },
                //     onChanged: (pin){
                //       print(pin);
                //     },
                //   ),
                // ),
                Center(
                  child: CountdownTimer(
                    endTime: endTime,
                    widgetBuilder: (context, CurrentRemainingTime? time) {
                      if (time == null) {
                        return TextButton(
                            onPressed: (){},
                            child: const Text('Resent OTP'),);
                      }

                      return Text(
                          '0${time.min ?? 0}: ${time.sec ?? 00}');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: widgets.textColorButton(
                    text: 'Submit',
                    onPress: () async {


                      final firstName = widget.user!.userDetails.firstName;
                      final secondName = widget.user!.userDetails.lastName;
                      final password = widget.user!.userDetails.password;
                      final phone = widget.user!.userDetails.phone;
                      final email = widget.user!.userDetails.email;

                      userDetails = await createUser(
                          otp: otpPin,
                          firstName: firstName,
                          secondName: secondName,
                          password: password,
                          phone: phone,
                          email: email);


                      print(userDetails!.user.name);
                      if(userDetails != null){

                        final preferences = await SharedPreferences.getInstance();
                        await preferences.setString("login", 'login');

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomePage(userDetails: userDetails),
                          ),
                        );
                      }else{
                        print('Null value');
                      }
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
