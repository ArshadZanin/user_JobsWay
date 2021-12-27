import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/model/fetch_feature_job_model.dart';
import 'package:jobs_way/pages/job_details_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FeaturedJobsPage extends StatefulWidget {
  FeaturedJobsPage({Key? key}) : super(key: key);

  @override
  State<FeaturedJobsPage> createState() => _FeaturedJobsPageState();
}

class _FeaturedJobsPageState extends State<FeaturedJobsPage> {

  final widgets = Get.put(WidgetController());

  Future<FeatureJobFetch?> fetchFeatureJobs(BuildContext context) async {

    String apiUrl = 'https://jobsway-user.herokuapp.com/api/v1/user/getfeaturedjobs';


    try{
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseString = response.body;

        print(responseString);

        return featureJobFetchFromJson('{"jobList":$responseString}');
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

  // @override
  // initState(){
  //   super.initState();
  //   fetchFeatureJobs(context);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          widgets.headingVersaTexts(
            colorText: 'Featured ',
            blackText: 'Jobs',
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchFeatureJobs(context),
              builder: (BuildContext context, AsyncSnapshot<FeatureJobFetch?> snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.jobList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var value = snapshot.data!.jobList![index];
                      return widgets.jobCardBlack(
                          srcImage:
                          'https://img.flaticon.com/icons/png/512/2702/2702602.png?'
                              'size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF',
                          companyName: 'Google',
                          companyLocation: value.jobLocation,
                          jobName: value.jobTitle!,
                          salaryRange: '30000 - 50000',
                          experience: '${value.minExp} - ${value.maxExp} year',
                          postTime: '10 days',
                          jobTime: value.timeSchedule!,
                          onTap: () {
                            print('$index');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => JobDetailsPage(),
                              ),
                            );
                          });
                    },
                  );
                }else{
                  return const Center(
                    child: CircularProgressIndicator(),
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
