import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_way/login_signup/forgot_password/forgot_otp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final widgets = Get.put(WidgetController());
  final phoneController = TextEditingController();

  Future<String?> forgotPasswordUser({
    required String phone,
  }) async {
    try {
      const String apiUrl =
          'https://jobsway-user.herokuapp.com/api/v1/user/forgot-password';
      final response = await http.post(Uri.parse(apiUrl), body: {
        "phone": phone,
      });

      if (response.statusCode == 200) {
        final responseString = jsonDecode(response.body);
        print(response.body);
        print(responseString);

        return responseString['status'];
        // return userModelOtpFromJson(responseString);
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
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              widgets.headingTexts(blackText: 'Forgot Password'),
              const Spacer(),
              widgets.textFieldGrey(
                label: 'Phone Number',
                textController: phoneController,
                keyboardType: TextInputType.number
              ),
              const SizedBox(
                height: 15,
              ),
              widgets.textColorButton(
                  text: 'Submit',
                  onPress: () async {
                    final phoneNumber = phoneController.text.trim();
                    if (phoneNumber.length == 10) {
                      var result = await forgotPasswordUser(phone: phoneNumber);
                      if (result == 'pending') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ForgotOtp(phoneNumber: phoneNumber,),
                          ),
                        );
                      } else {
                        print('error on result $result');
                      }
                    } else {
                      Get.snackbar(
                        'Something went Wrong!',
                        'Check your Phone Number',
                      );
                    }
                  }),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
