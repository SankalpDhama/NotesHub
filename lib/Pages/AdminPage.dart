import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import 'PdfViewScreen.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<QueryDocumentSnapshot> pdfData = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void deletePdf(String fileName) async {
    await _firestore.collection("report").doc(fileName).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
    // sem wala delete krna h kl krege
    await _firestore.collection("report").doc(fileName).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

  void getAllPdf() async {
    try {
      final results = await _firestore.collection('report').get();
      setState(() {
        pdfData = results.docs.toList();
      });
      print("fetching");
    } catch (f) {
      print(f);
    }
  }

  void initState() {
    super.initState();
    getAllPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sankalp'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('report').snapshots(),
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
                                PdfView(fileUrl: pdfData[index]['Link']),
                          ),
                        );
                      },
                      child: Image.asset(
                        "assets/images/infocard/college.jpg",
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          deletePdf(pdfData[index]['name']);
                          setState(() {
                            getAllPdf();
                          });
                          _showSuccessFlash(context, 'successfully Deleted');
                        },
                        child:Icon(Icons.delete),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 10, color: Colors.transparent),
                            color: const Color.fromRGBO(0, 0, 0, 0.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Name: ${pdfData[index]['name']}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Description: ${pdfData[index]['desc']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
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
}
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
