import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/pages/test_job_page.dart';

class JobDetailsPage extends StatelessWidget {
  JobDetailsPage({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
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
                                  horizontal: 20, vertical: 20),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.network(
                                  'https://img.flaticon.com/icons/png/512/2702/2702602.png?'
                                  'size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Google',
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
                            'Bengaluru, India',
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
              ),
              Center(
                child: Text(
                  'Sr.Flutter Developer',
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
                    '₹ 30000 - 50000',
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    'Full time',
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
              Row(
                children: [
                  Text(
                    'Qualification :',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              Text(
                'In publishing and graphic design, Lorem ipsum is'
                ' a placeholder text commonly used .',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                'In publishing and graphic design, Lorem ipsum is'
                ' a placeholder text commonly used .',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                'In publishing and graphic design, Lorem ipsum is'
                ' a placeholder text commonly used .',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                'In publishing and graphic design, Lorem ipsum is'
                ' a placeholder text commonly used .',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Education :',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              Text(
                'Bachelor of Computer Application',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Languages :',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'English',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Malayalam',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Hindi',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Spanish',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
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
                    'Skills :',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Dart',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Flutter',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Android',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
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
                    '4 - 8 years',
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
                        builder: (_) => TestJobPage(),
                      ),
                    );
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
