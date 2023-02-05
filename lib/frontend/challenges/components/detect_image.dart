import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:hackathon/frontend/components/primary_btn.dart';
import 'package:hackathon/theme.dart';
import 'package:image_picker/image_picker.dart';

import '../../../backend/database/database.dart';
import '../../../size.dart';

class DetectImage extends StatefulWidget {
  const DetectImage({super.key});
  @override
  State<DetectImage> createState() => _DetectImageState();
}

class _DetectImageState extends State<DetectImage> {
  final box = GetStorage();
  String? title = "", desc = "";
  FirebaseDatabase databaseRef = FirebaseDatabase.instance;
  String? location;
  bool isClicked = false;

  List<String> organic = [""];

  Future<bool> detectImage() async {
    // print("called this");
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage
        .ref()
        .child('/${GetStorage().read("email")}${DateTime.now().toString()}');

    //Upload the file to firebase

    UploadTask uploadTask = reference.putFile(file!);

    // Waits till the file is uploaded then stores the download url
    // Uri location = (await uploadTask.).downloadUrl;
    uploadTask.then((p0) async {
      location = await p0.ref.getDownloadURL();
      print(location);
      setState(() {});
    });
    return true;
  }

  File? file;
  Future<File> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    getImageLabels(image!);

    print("Done");

    return xFileToImage(image);
  }

  Future<File> xFileToImage(XFile xFile) async {
    // return Image.file(File(xFile.path));
    return File(xFile.path);
  }

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    if (file != null && location == null) {
      detectImage();
    }
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: getWidth(34),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: getWidth(24),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "Detect Image",
                  style: TextStyle(
                    color: pallete.primaryDark(),
                    fontSize: getWidth(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          // const Spacer(),

          const Spacer(),
          SizedBox(height: getHeight(40)),
          Container(
            width: getWidth(300),
            height: getWidth(300),
            decoration: BoxDecoration(
              border: Border.all(color: pallete.primaryDark()),
              borderRadius: BorderRadius.circular(10),
              color: pallete.primary().withOpacity(0.2),
            ),
            child: location == null
                ? Center(
                    child: SizedBox(
                      width: getWidth(40),
                      height: getWidth(40),
                      child: CircularProgressIndicator(
                        color: pallete.primary(),
                      ),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: location!,
                  ),
          ),
          SizedBox(height: getHeight(40)),
          (file == null)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        file = await pickImage();
                        setState(() {});
                      },
                      highlightColor: Colors.transparent,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Pick image",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: pallete.primaryDark(),
                                fontSize: getWidth(18),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: getWidth(5)),
                            Center(
                              child: Icon(
                                Icons.camera_rounded,
                                size: getWidth(22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          // SizedBox(height: getHeight(40)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PrimaryBtn(
              primaryColor: pallete.primaryDark(),
              secondaryColor: pallete.primaryDark().withOpacity(0.9),
              padding: 0,
              title: "Continue",
              tap: () async {
                if (file != null) {
                  isClicked = true;
                  await detectImage();
                  Navigator.pop(context);
                }
              },
              titleColor: pallete.background(),
              hasIcon: false,
            ),
          ),
        ],
      )),
    );
  }
}

void getImageLabels(XFile image) async {
  final inputImage = InputImage.fromFilePath(image.path);
  ImageLabeler imageLabeler = ImageLabeler(options: ImageLabelerOptions());
  List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
  for (ImageLabel imageLabel in labels) {
    String labelText = imageLabel.label;
    double confidence = imageLabel.confidence;
    print("Label : " + labelText);
    print("Confidence : " + confidence.toString());
  }
  imageLabeler.close();
}
