import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:jobs_way/controller/widget_controller.dart';
import 'package:jobs_way/image_pick/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApplyJobPage extends StatefulWidget {
  ApplyJobPage({Key? key,this.jobId}) : super(key: key);

  String? jobId;

  @override
  _ApplyJobPageState createState() => _ApplyJobPageState();
}

class _ApplyJobPageState extends State<ApplyJobPage> {

  bool _isLoading = false;

  final widgets = Get.put(WidgetController());

  File? filePdf;
  File? image;
  Uint8List? bytesImage;
  bool showImage = false;

  ///assing controllers
  final firstNameC = TextEditingController();
  final secondNameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final locationC = TextEditingController();
  final yearExpC = TextEditingController();
  final portfolioC = TextEditingController();
  final resumeController = TextEditingController();

  ///assign variables
  String firstName = '';
  String secondName = '';
  String email = '';
  String phone = '';
  String location = '';
  String yearExp = '';
  String portfolio = '';

  @override
  initState() {
    super.initState();
    retrieveData().whenComplete(() async {

      if(secondName.isEmpty){
        List<String> name = firstName.split(' ');
        firstName = name[0];
        secondName = name[1];
      }


      firstNameC.text = firstName;
      secondNameC.text = secondName;
      locationC.text = location;
      emailC.text = email;
      phoneC.text = phone;
      yearExpC.text = '';
      portfolioC.text = portfolio;


      if(bytesImage != []){
        showImage = true;
        Directory tempDir = await getTemporaryDirectory();
        var tempPath = tempDir.path;
        // await File('$tempPath/profile.png').delete();
        File file = File('$tempPath/profile${widgets.i}.png');
        await file.writeAsBytes(bytesImage!.buffer
            .asUint8List(bytesImage!.offsetInBytes, bytesImage!.lengthInBytes));
        image = file;
      }else{
        showImage = false;
      }
      setState(() {});
      widgets.increment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          'Apply Job',
          style: GoogleFonts.poppins(
            color: const Color(0xFF008FAE),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              widgets.headingTexts(blackText: 'Enter the details :'),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () async {
                      image = (await Utils.pickImage(
                        cropImage: cropSquareImage,
                      ));
                      if(image != null){
                        showImage = true;
                      }

                      setState(() {});
                    },
                    child: Container(
                      height: 300,
                      width: 225,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: image != null ? Image.file(image!): Container(),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: widgets.textFieldGrey(
                      label: 'First Name',
                      textController: firstNameC,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: widgets.textFieldGrey(
                      label: 'Second Name',
                      textController: secondNameC,
                    ),
                  ),
                ],
              ),

              widgets.textFieldGrey(
                label: 'Email',
                textController: emailC,
              ),
              widgets.textFieldGrey(
                label: 'Phone',
                textController: phoneC,
                keyboardType: TextInputType.number,
              ),
              widgets.textFieldGrey(
                label: 'Location',
                textController: locationC,
              ),
              widgets.textFieldGrey(
                label: 'Year of Experience',
                textController: yearExpC,
                keyboardType: TextInputType.number,
              ),
              widgets.textFieldGrey(
                label: 'Portfolio Link',
                textController: portfolioC,
              ),
              Row(
                children: [
                  Expanded(
                    child: widgets.textFieldGrey(
                      textController: resumeController,
                      readOnly: true,
                      label: 'Upload Resume',
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.upload),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if(result == null) return;
                      ///open this file
                      var file = result.files.first;
                      // final newFile = await saveFilePermanently(file);
                      // var newFile = file.getSomeCorrectFile();
                      filePdf = File(file.path!);

                      setState(() {
                        resumeController.text = file.name;
                      });
                    },),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: widgets.textColorButtonCircle(
                  text: 'Apply',
                  onPress: () async {

                    firstName = firstNameC.text;
                    secondName = secondNameC.text;
                    email = emailC.text;
                    phone = phoneC.text;
                    location = locationC.text;
                    yearExp = yearExpC.text;
                    portfolio = portfolioC.text;


                    _isLoading = true;
                    setState(() {

                    });

                  yearExp = yearExpC.text;

                  print('apply started');


                  await postApplyJob(context);
                  setState(() {
                  });

                }, isLoading: _isLoading,),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<File?> cropSquareImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );
  Future<void> retrieveData() async{
    final preferences = await SharedPreferences.getInstance();
    String? result = preferences.getString("image");
    if(result != null){
      bytesImage = base64Decode(result);
    }


    String? firstNameGet = preferences.getString("firstName");
    firstName = firstNameGet ?? '';

    String? secondNameGet = preferences.getString("secondName");
    secondName = secondNameGet ?? '';

    String? locationGet = preferences.getString("location");
    location = locationGet ?? '';

    String? emailGet = preferences.getString("email");
    email = emailGet ?? '';

    String? phoneGet = preferences.getString("phone");
    phone = phoneGet ?? '';

    String? portfolioGet = preferences.getString("portfolio");
    portfolio = portfolioGet ?? '';




    setState(() {

    });
  }

  Future<void> postApplyJob(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //create multipart request for POST or PATCH method
    // var user = prefs.get("userData");
    // var userEncode = jsonEncode(user);
    // var userDecode = jsonDecode(userEncode);
    // var userDetails = jsonDecode(userDecode);
    // var userId = await userDetails['_id'];


    String fileExtension =
        image!.path.split('/').last.split('.').last;


    final bytes = await image!.readAsBytes();
    var value = base64.encode(bytes);

    var stream = http.ByteStream(filePdf!.openRead());
    stream.cast();

    var length = await filePdf!.length();

    try {

      String userId = '';

      final preferences = await SharedPreferences.getInstance();
      String? idGet = preferences.getString("id");
      if(idGet != null){
        userId = idGet;
      }else{
        return;
      }


      String apiUrl = 'https://jobsway-user.herokuapp.com/api/v1/user/applyjob/${widget.jobId}';

      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));

      Map<String, String> fieldMap = {
        'userId' : userId,
        'firstName' : firstName,
        'secondName' : secondName,
        'email' : email,
        'phone' : phone,
        'location' : location,
        'experience' : yearExp,
        'portfolio' : portfolio,
        'image' : """data:image/$fileExtension;base64,$value"""
      };
      request.fields.addAll(fieldMap);
      print(fieldMap);
      // request.fields["firstName"] = firstName;
      // request.fields["lastName"] = secondName;
      // request.fields["email"] = email;
      // request.fields["phone"] = phone;
      // request.fields["location"] = location;
      // request.fields["experience"] = yearExp;
      // request.fields["portfolio"] = portfolio;
      // request.fields["image"] = """data:image/$fileExtension;base64,$value""";

      // Map<String, String> requestHeaders = {
      //   'Authorization': '${prefs.getString('userToken')}',
      // };
      // request.headers.addAll(requestHeaders);

      var multipartFile = http.MultipartFile("pdf", stream, length,
          filename: basename(filePdf!.path));
      request.files.add(multipartFile);

      print('data sending');
      var response = await request.send();

      // print(response);
      if (response.statusCode == 200) {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Job Applied', textAlign: TextAlign.center,),
        ));
        Navigator.pop(context);
        print("UPLOADED");

      }else{
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Try Again!', textAlign: TextAlign.center,),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong!', textAlign: TextAlign.center,),
      ));
      _isLoading = false;
    }
  }
  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

}
