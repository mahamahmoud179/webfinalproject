import 'package:admin/firebase/firebasehelper.dart';
import 'package:admin/landing_page.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  static const String id = "AuthScreen";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String password = '';
  String email = '';
  String? uid;

  User? user;
  bool isLoading=false;
  submit()async{
    if(formKey.currentState!.validate()){
      setState(() {
        isLoading=true;
      });
      user = await signInWithEmailPassword(email, password);
      print(user!.email);
        Navigator.of(context).pushNamed(LandingPage.id);

      setState(() {
        isLoading=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Container(
            height: 400.0,
            width: 400.0,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            child: isLoading?Center(child: CircularProgressIndicator(),):Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100.0,
                    // width: 150,
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => email = value,
                    decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        border: const OutlineInputBorder()),
                    validator: (val) {
                      if (val!.isEmpty) return "Enter A Valid Email";
                      else if(val.trim() != "admin@gmail.com")return "Enter A Valid Email";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) => password = value,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        border: const OutlineInputBorder()),
                    validator: (val) {
                      if (val!.isEmpty) return "Enter Your Password";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton.icon(
                      onPressed: submit,
                      icon: Icon(
                        Icons.login,
                        color: Colors.white54,
                      ),
                      label: Text("LOGIN"))
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }


  



}
