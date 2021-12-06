import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/pages/job_details_page.dart';

class FeaturedJobsPage extends StatelessWidget {
  FeaturedJobsPage({Key? key}) : super(key: key);

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20,),
          widgets.headingVersaTexts(
            colorText: 'Featured ',
            blackText: 'Jobs',
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index){
                  return widgets.jobCardBlack(
                    srcImage:
                    'https://img.flaticon.com/icons/png/512/2702/2702602.png?'
                        'size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF',
                    companyName: 'Google',
                    companyLocation: 'Bangalore, India',
                    jobName: 'Sr.Flutter Developer',
                    salaryRange: '30000 - 50000',
                    experience: '4 - 8 year',
                    postTime: '10 days',
                    jobTime: 'full time',
                    onTap: (){
                      print('$index');
                      Navigator.push(context, MaterialPageRoute(builder: (_) => JobDetailsPage()));
                    }
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
