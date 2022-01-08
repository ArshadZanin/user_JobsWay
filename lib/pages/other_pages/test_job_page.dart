import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/model/task_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TestJobPage extends StatefulWidget {
  const TestJobPage({Key? key, required this.taskList}) : super(key: key);
  final TaskListElement taskList;


  @override
  State<TestJobPage> createState() => _TestJobPageState();
}

class _TestJobPageState extends State<TestJobPage> {

  final widgets = Get.put(WidgetController());

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 0;

  bool timeout = false;

  final answerController = TextEditingController();


  Future<bool> testJob() async {

    final preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString("id");

    try{

      String apiUrl =
          'https://jobsway-user.herokuapp.com/api/v1/user/task/completed/$id';
      print(apiUrl);
      print(widget.taskList.id);
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "answerUrl": answerController.text.trim(),
          "taskId" : widget.taskList.id
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final String responseString = response.body;
        print(responseString);
        var jsonValue = jsonDecode(responseString);
        if(jsonValue['msg'] == "Task Submitted Successfully."){
          return true;
        }else{
          return false;
        }
        // return userModelOtpFromJson(responseString);
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}',textAlign: TextAlign.center,),
          ));
        }
        return false;
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
    return false;
  }

  @override
  initState(){
    super.initState();
    var time = int.parse(widget.taskList.time!) * 60;
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * time;
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          'Test for Job',
          style: GoogleFonts.poppins(
            color: const Color(0xFF008FAE),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text('1.'),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('${widget.taskList.taskQuestions!.q1}'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text('2.'),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('${widget.taskList.taskQuestions!.q2}'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text('3.'),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('${widget.taskList.taskQuestions!.q3}'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text('4.'),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('${widget.taskList.taskQuestions!.q4}'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Upload the file before the timer ends.',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CountdownTimer(
                    endTime: endTime,
                    widgetBuilder: (context, CurrentRemainingTime? time) {
                      if (time == null) {
                        timeout = true;
                        return Text(
                            'Time out',
                          style: TextStyle(color: Colors.red[500],fontSize: 16),
                        );
                      }

                      var min = time.min.toString();
                      var sec = time.sec.toString();

                      if(min.length == 1){
                        min = '0' + min;
                      }else if(min == 'null'){
                        min = '00';
                      }
                      if(sec.length == 1){
                        sec = '0' + sec;
                      }else if(sec == 'null'){
                        sec = '00';
                      }

                      return Text(
                          '$min: $sec',
                        style: TextStyle(color: Colors.blue[500],fontSize: 16),
                      );
                    },
                  ),
                ),
              ),
              widgets.textFieldGrey(
                label: 'Paste answer link',
                textController: answerController,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: widgets.textColorButton(
                    text: !timeout ? 'Submit Task' : 'Go Back',
                    onPress: () async {
                      var result = await testJob();
                      if(result){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Task Uploaded',textAlign: TextAlign.center,),
                        ));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Task Not Uploaded',textAlign: TextAlign.center,),
                        ));
                      }
                      Navigator.pop(context);
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const HomePage(),
                      //   ),
                      // );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
