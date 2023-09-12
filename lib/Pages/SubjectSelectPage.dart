import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:noteshub/Pages/HomePage.dart';
import 'package:noteshub/Pages/LoginPage.dart';
import 'package:noteshub/Resources/AuthService.dart';

class SubjectSelect extends StatefulWidget {
  const SubjectSelect({super.key, required this.branch, required this.sem});
  final String branch;
  final String sem;

  @override
  State<SubjectSelect> createState() => _SubjectSelectState();
}

class _SubjectSelectState extends State<SubjectSelect> {
  Map<String, dynamic>? data;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(widget.branch)
          .doc(widget.sem)
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          data = documentSnapshot.data() as Map<String, dynamic>;
        });
        print('data fetched ');
        // data?.forEach((key, value) {
        //   print('$key: $value');
        // });
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return DataDisplayScreen(data: data!);
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: Center(),
      );
    }
  }
}

class DataDisplayScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  DataDisplayScreen({required this.data});
  final _auth =AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetched Data'),
        actions: [
          IconButton(onPressed: (){
            _auth.signOut();
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(const IconData(0xe3b3, fontFamily: 'MaterialIcons')))
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          String key = data.keys.elementAt(index);
          dynamic value = data[key];
          return ListTile(
            title: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      subject: value.toString(),
                      sem: 'sem1',
                    ),
                  ),
                );
              },
              child: Text(
                value.toString(),
              ),
            ),
            // subtitle: Text(value.toString()),
          );
        },
      ),
    );
  }
}
