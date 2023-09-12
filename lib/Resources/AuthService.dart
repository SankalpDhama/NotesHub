import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteshub/Resources/sharedPreferences.dart';

class AuthService{
  static String userPhotoUrl="";
  static String displayName="";
  static String role="";
  static String uid="";
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Stream<User?> get authChanges => FirebaseAuth.instance.authStateChanges();
  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res=false;
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user=userCredential.user;
      if(user!=null){
        if(userCredential.additionalUserInfo!.isNewUser){
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'username':user.displayName,
            'uid':user.uid,
            'profilePhoto':user.photoURL,
            'role':'Student',
          });
        }
      res=true;
        print(user.displayName);
        userPhotoUrl=user.photoURL!;
        displayName=user.displayName!;
        uid=user.uid;
        DocumentSnapshot doc=await FirebaseFirestore.instance.collection('users').doc(uid).get();
        Map<String,dynamic>? temp=doc.data() as Map<String,dynamic>;
        if(temp==null){
          print("temp is null");
          role='Student';
        }else{
          print(temp);
          role=temp["role"];
          print(AuthService.role+"role value not null case");
        }
      }
    } on FirebaseAuthException catch (e) {
      res=false;
    }
    return res;
  }
  void signOut() async{
    try{
      FirebaseAuth.instance.signOut();
      removeValuesSF('Branch');
      removeValuesSF('sem');
    }catch(e){
      print(e);
    }
  }
  // Future<String> fetchData() async{
  //   DocumentSnapshot documentSnapshot=await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   Map<String,dynamic>? data=documentSnapshot.data() as Map<String,dynamic>;
  //   if(data!=null){
  //     return 'Student';
  //   }
  //   return data['role'];
  // }
}
