import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/backend/database/database.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});
  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  FirebaseDatabase databaseRef = FirebaseDatabase.instance;
  Future<bool> uploadImage() async {
    // print("called this");
    FirebaseStorage _storage = FirebaseStorage.instance;
    Reference reference = _storage
        .ref()
        .child('/${GetStorage().read("email")}${DateTime.now().toString()}');

    String? location;
    //Upload the file to firebase

    UploadTask uploadTask = reference.putFile(file!);

    // Waits till the file is uploaded then stores the download url
    // Uri location = (await uploadTask.).downloadUrl;
    uploadTask.then((p0) async {
      location = await p0.ref.getDownloadURL();
      print(location);
      Database.createPost(databaseRef, location!, "");
    });
    return true;
  }

  File? file;
  Future<File> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    return xFileToImage(image!);
  }

  Future<File> xFileToImage(XFile xFile) async {
    // return Image.file(File(xFile.path));
    return File(xFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Padding(
            // color: Colors.red,
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              FontAwesomeIcons.multiply,
              size: 30,
              color: Colors.black,
            ),
          ),
          onTap: () {
            // print("hello");
            Navigator.pop(context);
          },
        ),
        leadingWidth: 35,
        title: Text(
          "New Post",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
              child: file == null
                  ? InkWell(
                      onTap: () async {
                        file = await pickImage();
                        setState(() {});
                      },
                      child: Column(
                        children: [Text("Pick image")],
                      ),
                    )
                  : Container()),
          InkWell(
            child: Container(
              child: Text("Create Post"),
              color: (file != null) ? Colors.blue : Colors.grey,
            ),
            onTap: () async {
              if (file != null) {
                await uploadImage();
                Navigator.pop(context);
                // Navigator.pop(context);
              }
            },
          ),
        ],
      )),
    );
  }
}
