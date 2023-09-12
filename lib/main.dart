import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteshub/Pages/HomePage.dart';
import 'package:noteshub/Pages/LoginPage.dart';
import 'package:noteshub/Pages/PdfViewScreen.dart';
import 'package:noteshub/Pages/WelcomePage.dart';
import 'package:noteshub/Pages/notUsed/SelectionPage.dart';
import 'package:noteshub/Resources/AuthService.dart';
import 'package:noteshub/constant/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/AdminPage.dart';
import 'Pages/SubjectSelectPage.dart';
import 'Pages/notUsed/otpPage.dart';
import 'Resources/sharedPreferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String branch="";
  String sem="";
  // getBranchFromSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   branch = prefs.getString('Branch')??"";
  // }
  // getSemFromSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   sem = prefs.getString('sem')??"";
  // }
  //
  @override
  void initState(){
      super.initState();
      getStringValuesSF('Branch');
      getStringValuesSF('sem');
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotesHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      initialRoute: '/',
      routes: {
        '/login':(context)=>const LoginPage(),
        '/select':(context)=>const WelcomePage(),
        // '/admin':(context)=>const AdminPage(),
      },
      home: StreamBuilder(
        stream: AuthService().authChanges,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData){
            // return const SubjectSelect(subject:'CSE',sem:'sem1');
            // String branch=getStringValuesSF('Branch');
            // String sem=getStringValuesSF('sem');
            if(branch!="" && sem!=""){
              return SubjectSelect(branch: branch, sem: sem);
            }
            return AdminPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
