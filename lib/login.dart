// import 'package:admin/screens/main/main_screen.dart';
//
// import 'main.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class Login extends StatefulWidget {
//   static const String id = "Login";
//
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   String email = "";
//   String password = "";
//   String username = '';
//   final FirebaseAuth_aut = FirebaseAuth.instance;
//
//   Future<void> LoginUser() async {
//     final user = (await FirebaseAuth_aut.signInWithEmailAndPassword(
//             email: email, password: password))
//         .user;
//     Navigator.pushNamed(context, MainScreen.id);
//   }
// ////
//   final _key = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Medical equipment maintenance"),
//       ),
//       //wrap colum
//       body: Form(
//         key: _key,
//         child: Column(
//           children: [
//             Expanded(
//               child: Hero(
//                 tag: 'logo',
//                 child: Container(
//                   width: 120,
//                   child: Image.asset("assets/images/logo.png", scale: 1.5),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               onChanged: (value) => username = value,
//               ///validator
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'This field can\'t be empty';
//                 }
//                 return null;
//               },
//               decoration: InputDecoration(
//                   hintText: "username", border: const OutlineInputBorder()),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               onChanged: (value) => email = value,
//               decoration: InputDecoration(
//                   hintText: "Enter Your Email",
//                   border: const OutlineInputBorder()),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               obscureText: true,
//               onChanged: (value) => password = value,
//               autocorrect: false,
//               decoration: InputDecoration(
//                   hintText: "Enter Your Password",
//                   border: const OutlineInputBorder()),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             CustomButton(() async {
//               // current state
//               if (_key.currentState!.validate()) {
//                 await LoginUser();
//               }
//             }, "Login")
//           ],
//         ),
//       ),
//     );
//   }
// }
