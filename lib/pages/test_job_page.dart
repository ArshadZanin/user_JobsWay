import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/widget_controller.dart';

class TestJobPage extends StatelessWidget {
  TestJobPage({Key? key}) : super(key: key);

  final widgets = Get.put(WidgetController());

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
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Text('1.'),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('How Dart works ? '),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Text('2.'),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('What is the difference between null '
                          'value and undefined value?'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Text('3.'),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('Provide a basic overview of push '
                          'technology. What are its benefits and '
                          'drawbacks?'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Text('4.'),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('Prepare an login page by managing '
                          'session and put the link'),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Upload the file before the timer ends.'),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('24m : 15s'),
              ),
              widgets.textFieldGrey(
                label: 'Upload Files',
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: widgets.textColorButton(
                    text: 'Submit Task',
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
