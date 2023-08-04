import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteshub/Components/infoCard.dart';
import 'package:noteshub/Resources/AuthService.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}
class _SelectionPageState extends State<SelectionPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(child: Text(AuthService.displayName)),
          SizedBox(width: 10,),
          Image.network(AuthService.userPhotoUrl,height: 20,width: 20,),
          SizedBox(width: 30,),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Select'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: ListView(
            children: [
              infoCard(name: "select your Branch", imageLoc: "assets/images/infocard/branch.jpg",collectionName: 'CollegeList',),
              infoCard(name: "select your Semester", imageLoc: "assets/images/infocard/semester.jpg",collectionName: 'CollegeList',),
              infoCard(name: "select your Subject", imageLoc: "assets/images/infocard/subject.jpg",collectionName: 'CollegeList',),
            ],
          ),
      ),
    );
  }
}


