import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/model/otp_signup_model.dart';
import 'package:jobs_way/pages/main_pages/home_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotOtp extends StatefulWidget {
  ForgotOtp({Key? key,required this.phoneNumber}) : super(key: key);
  String phoneNumber;

  @override
  _ForgotOtpState createState() => _ForgotOtpState();
}

class _ForgotOtpState extends State<ForgotOtp> {

  UserModelOtp? userDetails;
  String otpPin = '';
  final widgets = Get.put(WidgetController());
  final otpController = TextEditingController();
  final errorController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  bool _isObscurePassword = true;
  bool _isObscureCPassword = true;


  Future<UserModelOtp?> otpForgotUser({
    required String otp,
    required String password,
    required String phone,
  }) async {
    try {
      const String apiUrl =
          'https://jobsway-user.herokuapp.com/api/v1/user/forgot-otp-verify';
      final response = await http.post(Uri.parse(apiUrl), body: {
        "otp" : otp,
        "phone" : phone,
        "newPassword" : password
      });

      if (response.statusCode == 200) {
        final responseString = response.body;

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
                //   child: PinCodeTextField(
                //     keyboardType: TextInputType.number,
                //     length: 6,
                //     obscureText: false,
                //     animationType: AnimationType.fade,
                //     pinTheme: PinTheme(
                //       inactiveFillColor: Colors.white,
                //       inactiveColor: const Color(0xFF008FAE),
                //       activeColor: const Color(0xFF008FAE),
                //       selectedFillColor: Colors.white,
                //       selectedColor: Colors.black,
                //       shape: PinCodeFieldShape.box,
                //       borderRadius: BorderRadius.circular(5),
                //       fieldHeight: 50,
                //       fieldWidth: 40,
                //       activeFillColor: Colors.white,
                //     ),
                //     animationDuration: const Duration(milliseconds: 300),
                //     enableActiveFill: true,
                //     // errorAnimationController: errorController,
                //     controller: otpController,
                //     onCompleted: (v) {
                //       print("Completed");
                //       otpPin = v;
                //     },
                //     onChanged: (value) {
                //       print(value);
                //       setState(() {
                //         print(value);
                //         // otpPin = value;
                //       });
                //     },
                //     beforeTextPaste: (text) {
                //       print("Allowing to paste $text");
                //       return true;
                //     }, appContext: context,
                //   ),
                // ),
                widgets.textFieldGreyObscure(
                  label: 'New Password',
                  textController: passwordController,
                  obscure: _isObscurePassword,
                  onPress: (){
                    _isObscurePassword ?
                    _isObscurePassword = false :
                    _isObscurePassword = true;
                    setState(() {

                    });
                  },
                ),
                widgets.textFieldGreyObscure(
                  label: 'Confirm Password',
                  textController: confirmController,
                  obscure: _isObscureCPassword,
                  onPress: () {
                    _isObscureCPassword ?
                    _isObscureCPassword = false :
                    _isObscureCPassword = true;
                    setState(() {

                    });
                  },
                ),
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
                      if(widget.phoneNumber.isEmpty){
                        return;
                      }

                      final password = passwordController.text;
                      final confirm = confirmController.text;

                      print(password);
                      print(otpPin);
                      print(widget.phoneNumber);

                      if(password == confirm){
                        print('data send');
                        var result = await otpForgotUser(
                          phone: widget.phoneNumber,
                          password: password,
                          otp: otpPin,
                        );

                        if(result!.user.id != null){
                          final user = result.user;
                          List<String> names = user.name.split(' ');
                          await initializePreference(
                            firstName: names[0],
                            secondName: names[1],
                              email: user.email,
                              id: user.id,
                              password: user.password,
                              token: result.token,
                              ban: user.ban,
                              phone: user.phone,
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(),),);

                        }
                      }

                      // if(userDetails != null){
                      //
                      //   final preferences = await SharedPreferences.getInstance();
                      //   await preferences.setString("login", 'login');
                      //
                      //   Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (_) => HomePage(userDetails: userDetails),
                      //     ),
                      //   );
                      // }else{
                      //   print('Null value');
                      // }

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

  Future<void> initializePreference({
    required String firstName,
    required String secondName,
    required String email,
    required String id,
    required String password,
    required String token,
    required bool ban,
    required String phone,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("login", 'login');
    await preferences.setString("firstName", firstName);
    await preferences.setString("secondName", secondName);
    await preferences.setString("email", email);
    await preferences.setString("phone", phone);
    await preferences.setString("id", id);
    await preferences.setString("password", password);
    await preferences.setString("token", token);
    await preferences.setBool("ban", ban);
  }

}
