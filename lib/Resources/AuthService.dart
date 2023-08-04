import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static String userPhotoUrl="https://unsplash.com/photos/peaTniZsUQs";
  static String displayName="";
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
          });
        }
      res=true;
        print(user.displayName);
        userPhotoUrl=user.photoURL!;
        displayName=user.displayName!;
      }
    } on FirebaseAuthException catch (e) {
      res=false;
    }
    return res;
  }
}
