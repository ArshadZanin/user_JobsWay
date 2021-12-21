import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosePlanPage extends StatefulWidget {
  const ChoosePlanPage({Key? key}) : super(key: key);

  @override
  _ChoosePlanPageState createState() => _ChoosePlanPageState();
}

class _ChoosePlanPageState extends State<ChoosePlanPage> {
  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: widgets.headingTexts(
                    blackText: 'Choose a ',
                    colorText: 'Plan.',
                  ),
                ),

                CarouselSlider(
                  items: [
                    freeCard(),
                    basicCard(),
                    premiumCard(),
                  ],
                  options: CarouselOptions(
                    height:  MediaQuery.of(context).size.width - 20,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    // autoPlayInterval: Duration(seconds: 3),
                    // autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (value, context){},
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget freeCard(){
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: 600,
        // width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: widgets.textWidget(
                        text: 'Free',
                        bold: true,
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    ///amount of plan
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: widgets.textWidget(
                          text: '\$0',
                          bold: true,
                          size: 70,
                          padding: const EdgeInsets.all(0.0),
                        ),
                      ),
                    ),
                    ///expiry data
                    Expanded(
                      child: Center(
                        child: widgets.textWidget(
                            text: 'Job Show for 3 Days',bold: true),
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    Expanded(
                      child: Center(
                        child: widgets.textWidget(
                            text: 'Only 1 job at a time.',bold: true,color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                final preferences = await SharedPreferences.getInstance();
                await preferences.setString("premium", "normal");
                widgets.premiumDeactivate();

                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultPage(),),);
                Navigator.pop(context);
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
              ),
              tileColor: const Color(0xFF5B40FF),
              title: Center(
                child: widgets.textWidget(
                  text: 'Select Plan',
                  bold: true,
                  color: Colors.white,
                ),),
            )
          ],
        ),
      ),
    );
  }

  Widget basicCard(){
    return Card(
      color: const Color(0xFF0A0047),
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widgets.textWidget(
                              text: 'Basic',
                              bold: true,
                              color: Colors.white
                          ),
                          widgets.greenButton(
                              onPress: (){},
                              label: 'Popular'),
                        ],
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    ///amount of plan
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: widgets.textWidget(
                          text: '\$12',
                          bold: true,
                          size: 70,
                          color: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                        ),
                      ),
                    ),
                    ///expiry data
                    Expanded(
                      child: Center(
                        child: widgets.textWidget(
                            text: 'Job Show for 15 Days',bold: true,color: Colors.white),
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    Expanded(
                      child: Center(
                        child: widgets.textWidget(
                            text: 'Only 10 jobs at a time.',bold: true,color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: (){
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultPage(),),);
                Navigator.pop(context);
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
              ),
              tileColor: const Color(0xFF5B40FF),
              title: Center(
                child: widgets.textWidget(
                  text: 'Select Plan',
                  bold: true,
                  color: Colors.white,
                ),),
            )
          ],
        ),
      ),
    );
  }

  Widget premiumCard(){
    return Card(
      color: const Color(0xFF0A0047),
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          widgets.textWidget(
                              text: 'Premium',
                              bold: true,
                              color: Colors.white
                          ),
                          const FaIcon(FontAwesomeIcons.crown,color: Colors.amber,),
                        ],
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    ///amount of plan
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: widgets.textWidget(
                          text: '\$20',
                          bold: true,
                          size: 70,
                          color: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                        ),
                      ),
                    ),
                    ///expiry data
                    Expanded(
                      child: Center(
                        child: widgets.textWidget(
                            text: 'Job Show for 30 Days',bold: true,color: Colors.white),
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    Expanded(
                      child: Center(
                        child: widgets.textWidget(
                            text: 'Post Unlimited Jobs.',bold: true,color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                final preferences = await SharedPreferences.getInstance();
                await preferences.setString("premium", "premium");
                widgets.premiumActivate();
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(),),);
                Navigator.pop(context);
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
              ),
              tileColor: const Color(0xFF5B40FF),
              title: Center(
                child: widgets.textWidget(
                  text: 'Select Plan',
                  bold: true,
                  color: Colors.white,
                ),),
            )
          ],
        ),
      ),
    );
  }

}
