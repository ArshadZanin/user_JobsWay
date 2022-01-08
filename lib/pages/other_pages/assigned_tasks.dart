import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/model/task_list_model.dart';
import 'package:jobs_way/pages/other_pages/test_job_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AssignedTaskPage extends StatefulWidget {
  const AssignedTaskPage({Key? key}) : super(key: key);

  @override
  _AssignedTaskPageState createState() => _AssignedTaskPageState();
}

class _AssignedTaskPageState extends State<AssignedTaskPage> {

  final widgets = Get.put(WidgetController());

  ///stream function
  Stream<TaskList?> fetchTasks() async* {
    final preference = await SharedPreferences.getInstance();
    var id = preference.getString('id');
    try {
      String apiUrl = 'https://jobsway-user.herokuapp.com/api/v1/user/tasks/$id';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseString = response.body;

        yield taskListFromJson('{"taskList": $responseString}');
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}',textAlign: TextAlign.center,),
          ));
        }
        yield null;
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Error!',textAlign: TextAlign.center,),
      ));
    }
  }

  @override
  initState(){
    super.initState();
    // fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widgets.headingTexts(
              blackText: 'Assigned',
              colorText: 'Tasks.',
            ),
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: fetchTasks(),
              builder: (BuildContext context, AsyncSnapshot<TaskList?> snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.taskList!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {

                      if(snapshot.data!.taskList!.isEmpty){
                        return const Center(
                          child: Text('No Assigned Tasks'),
                        );
                      }

                      final value = snapshot.data!.taskList![index];
                      return widgets.completeTaskCard(
                        srcImage:
                        '${value.companyDetails![0].logoUrl}',
                        companyName: '${value.companyDetails![0].companyName}',
                        companyLocation: '${value.companyDetails![0].location}',
                        duration: '${value.time}',
                        onPress: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TestJobPage(taskList: value,),
                            ),
                          );
                          fetchTasks();
                        },
                      );
                    },
                  );
                }else{
                  return Center(
                    // child: CircularProgressIndicator(),
                    child: Platform.isAndroid ?
                    const CircularProgressIndicator() :
                    const CupertinoActivityIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
