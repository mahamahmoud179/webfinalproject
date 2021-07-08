
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<bool> getUser() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool authSignedIn = prefs.getBool('auth') ?? false;

  final User? user = _auth.currentUser;

  if (authSignedIn == true) {
    if (user != null) {
      String uid = user.uid;
    }
  }
  return authSignedIn;
}


Future<User?> signInWithEmailPassword(String email,String password) async {
  User? user;

  try {
    print("Done1");
    // print("$email $password");
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).catchError((e)=>print(e));

    user = userCredential.user;
    // print("${user!.email}");

    if (user != null) {
      String uid = user.uid;
      // email= user.email!;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth', true);
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }
  }

  return user;
}

Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  return 'User signed out';
}