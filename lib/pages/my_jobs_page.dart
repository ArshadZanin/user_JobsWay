import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({Key? key}) : super(key: key);

  @override
  _MyJobsPageState createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            widgets.completeTaskCard(
                srcImage:
                'https://img.flaticon.com/icons/png/512/2702/2702602.png?'
                    'size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF',
                companyName: 'Google',
                companyLocation: 'Bangalore, India',
                onPress: () {  }
                ),
            widgets.headingTexts(
                blackText: 'My',
              colorText: 'Jobs Details:',
            ),
            const SizedBox(height: 10,),
            widgets.jobDetailsCard(
                statusWidget: widgets.pendingField((){}),
                srcImage:
                'https://img.flaticon.com/icons/png/512/2702/2702602.png?'
                    'size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF',
              jobName: 'Sr.Flutter Developer',
              jobLocation: 'Bangalore, India'
            ),
            widgets.jobDetailsCard(
                statusWidget: widgets.approvedField((){}),
                srcImage:
                'https://img.flaticon.com/icons/png/512/2702/2702602.png?'
                    'size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF',
                jobName: 'Sr.Flutter Developer',
                jobLocation: 'Bangalore, India'
            ),
            widgets.jobDetailsCard(
                statusWidget: widgets.rejectField((){}),
                srcImage:
                'https://img.flaticon.com/icons/png/512/2702/2702602.png?'
                    'size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF',
                jobName: 'Sr.Flutter Developer',
                jobLocation: 'Bangalore, India'
            ),
          ],
        ),
      ),
    );
  }
}
