import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/controller/api_controller.dart';
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
  final apis = Get.put(ApiController());


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
            widgets.textColorButton(text: 'Search', onPress: (){
              apis.fetchUser(context);
              pageIndex = 1;
              setState(() {
              });
            }),
            const SizedBox(height: 25,),
            const Divider(height: 1,thickness: 5,),
          ],
        ),
      ),
    );
  }

  Widget secondPage(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          widgets.textFieldGrey(
            label: 'Search for Jobs, Companies, categories',
            textController: searchController,
          ),
          Row(
            children: [
              Expanded(
                child: widgets.textFieldGrey(
                  label: 'Location',
                  textController: locationController,
                ),
              ),
              const SizedBox(width: 5,),
              widgets.textColorButton(text: 'Search', onPress: (){
                pageIndex = 1;
                setState(() {

                });
              }),
            ],
          ),
          const SizedBox(height: 15,),
          const Divider(height: 1,thickness: 2,),
          const SizedBox(height: 15,),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
            itemCount: 10,
              itemBuilder: (context, index){
                return const SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: ListTile(
                      title: Text("Job Title"),
                    ),
                  ),
                );
              },
          ),)
        ],
      ),
    );
  }

}
