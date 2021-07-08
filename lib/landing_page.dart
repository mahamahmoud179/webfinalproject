import 'package:admin/firebase/firebasehelper.dart';
import 'package:admin/screens/main/auth_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget {
  static const String id = "LandingPage";
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLogin=false;
  Future getUserInfo() async {
    isLogin = await getUser();
    setState(() {});
    // print(uid);
  }
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!=null?MainScreen():AuthScreen();
  }
}
