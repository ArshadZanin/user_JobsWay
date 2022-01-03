import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/model/fetch_feature_job_model.dart';
import 'package:jobs_way/model/job_fetch_model.dart';
import 'package:jobs_way/pages/main_pages/job_details_page.dart';
import 'package:http/http.dart' as http;

class AllJobsPage extends StatefulWidget {
  const AllJobsPage({Key? key}) : super(key: key);

  @override
  State<AllJobsPage> createState() => _AllJobsPageState();
}

class _AllJobsPageState extends State<AllJobsPage> {

  final widgets = Get.put(WidgetController());

  final _scroll = ScrollController();

  int listLength = 0;
  int listViewLength = 8;


  Stream<JobFetch?> fetchFeatureJobs(BuildContext context) async* {
    String apiUrl = 'https://jobsway-user.herokuapp.com/api/v1/user/getjobs';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseString = response.body;


        yield jobFetchFromJson('{"jobList":$responseString}');
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}', textAlign: TextAlign.center,),
          ));
        }
        yield null;
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check network connection', textAlign: TextAlign.center,),
      ));
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e', textAlign: TextAlign.center,),
      ));
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e', textAlign: TextAlign.center,),
      ));
    }
  }

  @override
  initState(){
    super.initState();
    _scroll.addListener(() {
     if(_scroll.position.pixels == _scroll.position.maxScrollExtent){
       listViewLength = listViewLength + 8;
       setState(() {
       });
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          widgets.headingVersaTexts(
            colorText: 'All ',
            blackText: 'Jobs',
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream: fetchFeatureJobs(context),
              builder: (BuildContext context,
                  AsyncSnapshot<JobFetch?> snapshot) {
                if (snapshot.hasData) {
                  listLength = snapshot.data!.jobList!.length;
                  if(listLength < listViewLength){
                    listViewLength = listLength;
                  }
                  return ListView.builder(
                    controller: _scroll,
                    itemCount: listViewLength,
                    itemBuilder: (BuildContext context, int index) {
                      var value = snapshot.data!.jobList![index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(
                              builder: (_) => JobDetailsPage(jobDetails: value,),),);
                          },
                          child: widgets.jobCardBlack(
                            srcImage: '${value.companyDetails![0].logoUrl}',
                            companyName: '${value.companyDetails![0].companyName}',
                            companyLocation: value.jobLocation,
                            jobName: value.jobTitle!,
                            salaryRange: '${value.minSalary} - ${value.minSalary}',
                            experience: '${value.minExp} - ${value
                                .maxExp} year',
                            postTime: '10 days',
                            jobTime: '${value.timeSchedule}',
                            // onTap: () {
                            //   print('$index');
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (_) => JobDetailsPage(),
                            //     ),
                            //   );
                            // }
                          ),
                        );
                    },
                  );
                } else {
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
