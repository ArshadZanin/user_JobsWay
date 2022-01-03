import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_way/model/job_fetch_model.dart';
import 'package:jobs_way/pages/other_pages/apply_job_page.dart';

class JobDetailsPage extends StatefulWidget {
  JobDetailsPage({Key? key, required this.jobDetails}) : super(key: key);

  JobList? jobDetails;

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          'Job Details',
          style: GoogleFonts.poppins(
            color: const Color(0xFF008FAE),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  '${widget.jobDetails!.companyDetails![0].logoUrl}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${widget.jobDetails!.companyDetails![0].companyName}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.jobDetails!.jobLocation}',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  '${widget.jobDetails!.jobTitle}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '₹ ${widget.jobDetails!.minSalary} - ${widget.jobDetails!.maxSalary}',
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    '${widget.jobDetails!.timeSchedule}',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Qualification :',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.jobDetails!.qualification!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      const Icon(Icons.arrow_forward_outlined),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Text(
                          widget.jobDetails!.qualification![index],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Education :',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(Icons.arrow_forward_outlined),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Text(
                      '${widget.jobDetails!.education}',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Languages :',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.jobDetails!.language!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      const Icon(Icons.arrow_forward_outlined),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Text(
                          widget.jobDetails!.language![index],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Skills :',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.jobDetails!.skills!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      const Icon(Icons.arrow_forward_outlined),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Text(
                          widget.jobDetails!.skills![index],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Job Overview :',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Experience\t\t:',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${widget.jobDetails!.minExp} - ${widget.jobDetails!.maxExp} years',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Posted Date\t\t:',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '20-10-2021',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'No. of Application\t\t:',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '17',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              widgets.textColorButton(
                  text: 'Apply Now',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ApplyJobPage(jobId: widget.jobDetails!.id,),
                      ),
                    );
                    // Navigator.pop(context);
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
