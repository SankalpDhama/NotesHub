import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteshub/Pages/SubjectSelectPage.dart';
import 'package:noteshub/Resources/AuthService.dart';
import 'package:noteshub/Resources/sharedPreferences.dart';

import '../Components/SelectionDialogBox.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final AuthService _auth=AuthService();
  String branch = "";
  String semester = "";
  String sel="Select Your";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTESHUB"),
        actions: [
          IconButton(onPressed: (){
            _auth.signOut();
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(const IconData(0xe3b3, fontFamily: 'MaterialIcons')))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          branch = (await getStringValuesSF('Branch'))??"";
          semester = (await getStringValuesSF('Semester'))??"";
          if (branch != "" && semester != "") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SubjectSelect(branch: branch, sem: semester),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Data is Empty"),
              ),
            );
          }
        },
        child: Text("Submit"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(
                "WELCOME TO NOTESHUB",
                style: GoogleFonts.getFont('Bungee Spice'),
              ),
              Image.asset("assets/images/logo/NotesLogo.png"),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const DialogWidget(
                        data: 'Branch',
                        list: ['CSE', 'IT', 'ECE'],
                      );
                    },
                  );
                },
                child: Text('${sel} Branch'),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const DialogWidget(
                        data: 'Semester',
                        list: [
                          'sem1',
                          'sem2',
                          'sem3',
                          'sem4',
                          'sem5',
                          'sem6',
                          'sem7',
                          'sem8'
                        ],
                      );
                    },
                  );
                },
                child: Text("${sel} Semester"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
