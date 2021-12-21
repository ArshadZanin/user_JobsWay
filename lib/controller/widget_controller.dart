import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way/pages/profile_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class WidgetController extends GetxController {
  RxBool premium = false.obs;

  void premiumActivate() {
    premium.value = true;
  }

  void premiumDeactivate() {
    premium.value = false;
  }

  var i = 1.obs;
  void increment() {
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

  Widget textFieldGrey({
    String label = '',
    TextEditingController? textController,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFE6E6E6),
      ),
      child: TextFormField(
        obscureText: obscure,
        keyboardType: keyboardType,
        readOnly: readOnly,
        controller: textController,
        maxLines: maxLines,
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

  Widget textFieldGreyObscure({
    String label = '',
    TextEditingController? textController,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    required bool obscure,
    required Function() onPress,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFE6E6E6),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              obscureText: obscure,
              keyboardType: keyboardType,
              readOnly: readOnly,
              controller: textController,
              maxLines: maxLines,
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
          ),
          Center(
            child: IconButton(
              onPressed: onPress,
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ),
        ],
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

  Widget textColorButtonCircle({
    required String text,
    required Function() onPress,
    required bool isLoading,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF008FAE)),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading ?
        const SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1,),) :
        Text(
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
          Badge(
            elevation: 0,
            showBadge: premium.value,
            badgeColor: Colors.transparent,
            badgeContent: const FaIcon(
              FontAwesomeIcons.crown,
              color: Colors.amber,
              size: 12.0,
            ),
            child: Text(
              'Way.',
              style: GoogleFonts.poppins(
                color: const Color(0xFF008FAE),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()));
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
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

  Widget iconTextButton(
      {required IconData icon,
      required String text,
      required Function() onPress}) {
    return TextButton(
      onPressed: onPress,
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xff000000),
            size: 50,
          ),
          Text(
            text,
            style: GoogleFonts.poppins(color: const Color(0xff000000)),
          ), //0xff008080
        ],
      ),
    );
  }

  Widget completeTaskCard({
    required Function() onPress,
    required String srcImage,
    required String companyName,
    String? companyLocation,
  }) {
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
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
                          text: 'Start Task', onPress: onPress)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pendingField(Function()? onPress) {
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

  Widget approvedField(Function()? onPress) {
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

  Widget rejectField(Function()? onPress) {
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
  }) {
    return Card(
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: Container(
          width: 53,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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

  Widget skillText({required String text}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          text,
          overflow: TextOverflow.fade,
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget textWidget({
    required String text,
    double size = 20.0,
    Color color = Colors.black,
    bool bold = false,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
  }) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: GoogleFonts.poppins(
            color: color,
            fontWeight: bold == true ? FontWeight.bold : null,
            fontSize: size),
      ),
    );
  }

  Widget greenButton({required Function() onPress, required String label}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xFF03C852),
        ),
      ),
      onPressed: onPress,
      child: Text(label),
    );
  }

  Widget otpField({void Function(String)? onCompleted, BuildContext? context}) {
    final otpController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: PinCodeTextField(
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          inactiveFillColor: Colors.white,
          inactiveColor: const Color(0xFF008FAE),
          activeColor: const Color(0xFF008FAE),
          selectedFillColor: Colors.white,
          selectedColor: Colors.black,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        // errorAnimationController: errorController,
        controller: otpController,
        onCompleted: onCompleted,
        onChanged: (value) {
          print(value);
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return true;
        },
        appContext: context!,
      ),
    );
  }
}
