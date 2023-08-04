import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:noteshub/Pages/PdfViewScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Resources/sharedPreferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _showSuccessFlash(BuildContext context, String message) {
    showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          backgroundColor: Colors.pinkAccent,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          content: Row(
            children: [
              Icon(Icons.check),
              SizedBox(
                width: 10,
              ),
              Text(message),
            ],
          ),
          // You can customize the appearance of the toast here
        );
      },
    );
  }
  //firebase methods
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPdf(String fileName, File file) async {
    final reference =
        FirebaseStorage.instance.ref().child("pdfs/$fileName.pdf");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await reference.getDownloadURL();
    return downloadLink;
  }
  void pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null) {
      String fileName = pickedFile.files[0].name;
      File file = File(pickedFile.files[0].path!);
      final downloadLink = await uploadPdf(fileName, file);
      try {
        _firestore.collection("1").add({
          "Name": fileName,
          "Link": downloadLink,
          "Subject": fileName,
          "Votes": 0,
        });
        print("success");
        _showSuccessFlash(context, "data added successfully");
      } on FirebaseException catch (e) {
        _showSuccessFlash(context, e.toString());
      }
    }
  }
  List<QueryDocumentSnapshot> pdfData = [];
  void getAllPdf() async {
    try {
      final results = await _firestore
          .collection('1')
          .orderBy("Votes", descending: true)
          .get();
      setState(() {
        pdfData = results.docs.toList();
      });
      print("fetching");
    } catch (f) {
      print(f);
    }
  }
  Future<void> incrementLikesCount(int index) async {
    try {
      var documentSnapshot = pdfData[index];
      await documentSnapshot.reference.update({
        'Votes': FieldValue.increment(1),
      });
      print('Likes count incremented successfully.');
      getAllPdf();
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Future<void> decrementLikesCount(int index) async {
    try {
      var documentSnapshot = pdfData[index];
      await documentSnapshot.reference.update({
        'Votes': FieldValue.increment(-1),
      });
      print('Likes count incremented successfully.');
      getAllPdf();
    } catch (e) {
      print('Error updating data: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    getAllPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Center(child: Text("Add a New Doc")),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: pickFile,
        ),
      ]),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('1').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return GridView.builder(
            itemCount: pdfData.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (context, index) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  PdfView(fileUrl: pdfData[index]['Link'])),
                        );
                      },
                      child: Image.asset(
                        "assets/images/infocard/college.jpg",
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      // baad mei dekhlio center mei kese kre
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 10, color: Colors.transparent),
                            color: const Color.fromRGBO(0, 0, 0,
                                0.5)
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pdfData[index]['Name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            Row(
                              children: [
                                FutureBuilder<Widget>(
                                  future: buildWidgetWithFuture(
                                      pdfData[index]['Name'], index),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    } else {
                                      return snapshot.data ?? Container();
                                    }
                                  },
                                ),
                                Text(
                                  pdfData[index]['Votes'].toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // buildAlign(index, context),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
  Widget likeButton(bool isLiked, String name, int index) {
    Color col = Colors.white;
    if (isLiked) {
      col = Colors.pinkAccent;
    }
    return IconButton(
      onPressed: () {
        if (!isLiked) {
          setState(() {
            col = Colors.pinkAccent;
          });
          incrementLikesCount(index);
          isLiked = true;
          addBoolToSF(name, isLiked);
        } else {
          setState(() {
            col = Colors.white;
          });
          decrementLikesCount(index);
          isLiked = false;
          addBoolToSF(name, isLiked);
        }
      },
      icon: Icon(Icons.favorite),
      color: col,
    );
  }
  Future<Widget> buildWidgetWithFuture(String name, int index) async {
    bool data = await checkBool(name);
    return likeButton(data, name, index);
  }
}