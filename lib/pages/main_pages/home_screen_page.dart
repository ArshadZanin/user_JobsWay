import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/api_controller.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/model/job_fetch_model.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_way/model/task_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'job_details_page.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {

  final searchController = TextEditingController();
  final locationController = TextEditingController();
  final widgets = Get.put(WidgetController());
  final apis = Get.put(ApiController());

  final _scroll = ScrollController();

  int listLength = 0;
  int listViewLength = 8;

  Stream<TaskList?> appiedTasks() async* {
    final preference = await SharedPreferences.getInstance();
    var id = preference.getString('id');
    try {
      String apiUrl = 'https://jobsway-user.herokuapp.com/api/v1/user/user-applied-jobs/$id';
      print(apiUrl);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseString = response.body;

        print('{"appliedJobs": $responseString}');
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


  Stream<JobFetch?> fetchFeatureJobs(BuildContext context, {String value = ''}) async* {
    String apiUrl = 'https://jobsway-user.herokuapp.com/api/v1/user/search/$value';


    print(apiUrl);

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



  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pageIndex == 0 ?
            firstPage(context) :
            secondPage(context),
    );
  }

  Widget firstPage(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 15,),
          widgets.headingTexts(
            blackText: 'Get the ',
            colorText: 'Right Job',
          ),
          widgets.headingTexts(blackText: 'You Deserve'),
          const SizedBox(height: 5,),
          Text(
            'Get new opportunity through JobsWay.',
            style: GoogleFonts.poppins(
                color: Colors.grey
            ),
          ),
          const SizedBox(height: 25,),
          widgets.textFieldGreySuffix(
            label: 'Search for Jobs, Companies, categories',
            textController: searchController,
            icon: IconButton(onPressed: () {
              pageIndex = 1;
              setState(() {
              });
            }, icon: const Icon(Icons.search),

            ),
          ),
          // const SizedBox(height: 15,),
          // widgets.textFieldGrey(
          //   label: 'Location',
          //   textController: locationController,
          // ),
          // const SizedBox(height: 25,),
          // widgets.textColorButton(text: 'Search', onPress: (){
          //   // apis.fetchUser(context);
          //   pageIndex = 1;
          //   setState(() {
          //   });
          //
          //   print(searchController.text);
          //
          //   // fetchFeatureJobs(context, value: searchController.text);
          //
          // }),
          const SizedBox(height: 5,),
          const Divider(height: 1,thickness: 1,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widgets.headingTexts(
              blackText: 'My',
              colorText: 'Jobs Details:',
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: Center(
              child: StreamBuilder(
                stream: appiedTasks(),
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
                        return widgets.jobDetailsCard(
                            statusWidget: widgets.pendingField((){}), //widgets.approvedField((){}), //widgets.rejectField((){}),
                            srcImage:
                            'https://img.flaticon.com/icons/png/512/2702/2702602.png?'
                                'size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF',
                            jobName: 'Sr.Flutter Developer',
                            jobLocation: 'Bangalore, India'
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
          ),
        ],
      ),
    );
  }

  Widget secondPage(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          widgets.textFieldGreySuffix(
            onChange:(value){
              if(searchController.text.isEmpty){
                pageIndex = 0;
                setState(() {
                });
              }else{
                fetchFeatureJobs(context, value: value);
                setState(() {
                });
              }
            },
            icon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                  pageIndex = 1;
                  setState(() {

                  });
                  fetchFeatureJobs(context, value: searchController.text);
                },
            ),
            label: 'Search for Jobs, Companies, categories',
            textController: searchController,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: widgets.textFieldGrey(
          //         label: 'Location',
          //         textController: locationController,
          //       ),
          //     ),
          //     const SizedBox(width: 5,),
          //   ],
          // ),
          const SizedBox(height: 15,),
          const Divider(height: 1,thickness: 2,),
          const SizedBox(height: 15,),
          Expanded(
            child: StreamBuilder(
              stream: fetchFeatureJobs(context,value: searchController.text),
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
                          salaryRange: '${value.minSalary ?? '***'} - ${value.minSalary ?? '***'}',
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
