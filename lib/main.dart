import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteshub/Pages/HomePage.dart';
import 'package:noteshub/Pages/LoginPage.dart';
import 'package:noteshub/Pages/PdfViewScreen.dart';
import 'package:noteshub/Pages/SelectionPage.dart';
import 'package:noteshub/Resources/AuthService.dart';
import 'package:noteshub/constant/colors.dart';

import 'Pages/otpPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
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
        '/otp':(context)=>const OtpPage(),
        '/select':(context)=>const SelectionPage(),
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
            return const SelectionPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
