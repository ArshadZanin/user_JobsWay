import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/model/task_list_model.dart';

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
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: widgets.textColorButton(
                    text: !timeout ? 'Submit Task' : 'Go Back',
                    onPress: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const HomePage(),
                      //   ),
                      // );
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
