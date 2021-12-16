import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/pages/profile_page.dart';

class WidgetController extends GetxController {

  var i = 1.obs;
  void increment(){
    i.value++;
  }

  Widget headingTexts({required String blackText, String colorText = ''}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          blackText,
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          colorText,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF008FAE),
          ),
        ),
      ],
    );
  }

  Widget headingVersaTexts({String blackText = '', required String colorText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          colorText,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF008FAE),
          ),
        ),
        Text(
          blackText,
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  Widget buttonWithText({
    required String text,
    required String buttonText,
    required Function() onPress,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: onPress,
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              color: const Color(0xff008080),
            ),
          ),
        ),
      ],
    );
  }

  Widget textFieldGrey(
      {String label = '', TextEditingController? textController}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFE6E6E6),
      ),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            color: const Color(0xffAEAEAE),
          ),
        ),
      ),
    );
  }

  Widget textColorButton({
    required String text,
    required Function() onPress,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF008FAE)),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    );
  }

  PreferredSizeWidget appbarCustom(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFF2F2F2),
      iconTheme: const IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Jobs',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Way.',
            style: GoogleFonts.poppins(
                color:const Color(0xFF008FAE),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ProfilePage()));
            },
            icon: const Icon(
              Icons.account_circle_outlined,
            )),
      ],
    );
  }

  Widget jobCardBlack({
    required String srcImage,
    required String companyName,
    String? companyLocation,
    required String jobName,
    String? salaryRange,
    String? experience,
    required String postTime,
    String jobTime = 'full time / part time',
    Function()? onTap,
  }) {
    return Card(
      color: const Color(0xFF2C2C2C),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.network(
                            srcImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            companyName,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            companyLocation!,
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '$postTime ago',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            jobTime,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          jobName,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₹$salaryRange',
                          style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$experience experience',
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Know more...',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconTextButton({required IconData icon, required String text, required Function() onPress}){
    return TextButton(
      onPressed: onPress,
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xff000000),
            size: 50,
          ),
          Text(text,style: GoogleFonts.poppins(color: const Color(0xff000000)),),//0xff008080
        ],
      ),
    );
  }

  Widget completeTaskCard({
  required Function() onPress,
    required String srcImage,
    required String companyName,
    String? companyLocation,

}){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: const Color(0xFF2C2C2C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.network(
                            srcImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            companyName,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            companyLocation!,
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Text(
                  'Complete Task',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Questions\t: 4',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Duration\t: 30 min',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                      child: textColorButton(
                          text: 'Start Task',
                          onPress: onPress)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pendingField(Function()? onPress){
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFFFFE39C)),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          'PENDING',
          style: GoogleFonts.poppins(color: const Color(0xff945900)),
        ),
      ),
    );
  }
  Widget approvedField(Function()? onPress){
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF03C852)),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          'APPROVED',
          style: GoogleFonts.poppins(color: const Color(0xff435737)),
        ),
      ),
    );
  }
  Widget rejectField(Function()? onPress){
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFFFF4E4E)),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          'REJECTED',
          style: GoogleFonts.poppins(color: const Color(0xff4F3030)),
        ),
      ),
    );
  }

  Widget jobDetailsCard({
  required Widget statusWidget,
    required String srcImage,
    required String jobName,
    String jobLocation = '',
}){
    return Card(
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: Container(
          width: 53,
          padding:
          const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: Image.network(
                srcImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          jobName,
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
          ),
        ),
        subtitle: Text(
          jobLocation,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        trailing: statusWidget,
      ),
    );
  }

  Widget skillText({required String text}){
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
            color: Colors.white,
        fontSize: 20),),
    );
  }



}
