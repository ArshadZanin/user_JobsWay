import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/login_signup/log_in.dart';
import 'package:jobs_way/model/user_data_fetch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiController extends GetxController{

  Future<UserDataFetch?> fetchUser(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("id");
    String id = '';
    if(idGet != null){
      id = idGet;
    }else{
      preferences.clear();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LogIn(),),);
    }

    try {
      String apiUrl =
          'https://jobsway-user.herokuapp.com/api/v1/user/get-user/$id';
      final response = await http.get(Uri.parse(apiUrl));

      print("response ${response.statusCode}");
      print(response.body);
      if (response.statusCode == 200) {
        final responseString = response.body;
        return userDataFetchFromJson(responseString);
      } else {
        return null;
      }
    } on SocketException {
      Get.snackbar('Something went Wrong!', 'Check network connection',
          icon: const Icon(Icons.network_check_outlined));
    } on TimeoutException catch (e) {
      Get.snackbar(
        'Something went Wrong!',
        '$e',
      );
    } on Error catch (e) {
      print("error $e");
    }
  }
}