import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/widget_controller.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {

  final searchController = TextEditingController();
  final locationController = TextEditingController();
  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              widgets.textFieldGrey(
                label: 'Search for Jobs, Companies, categories',
                textController: searchController,
              ),
              const SizedBox(height: 15,),
              widgets.textFieldGrey(
                label: 'Location',
                textController: locationController,
              ),
              const SizedBox(height: 25,),
              widgets.textColorButton(text: 'Search', onPress: (){}),
              const SizedBox(height: 25,),
              const Divider(height: 1,thickness: 5,),
            ],
          ),
        ),
      ),
    );
  }
}
