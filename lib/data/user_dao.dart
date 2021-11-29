import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hitch_hiking/home_page/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDao extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _username;

  final auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  // 1
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

// 2
  String? userId() {
    return auth.currentUser?.uid;
  }

//3
  String? email() {
    return auth.currentUser?.email;
  }

  Future<User?> googleLogin(String email, String password) async {
    User? user;
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      try {
        UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        print(user);
        print(userId());
        notifyListeners();

        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
    return user;
  }

  void logout() async {
    await googleSignIn.signOut();
    await auth.signOut();
    notifyListeners();
  }
}
