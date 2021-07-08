// import 'package:admin/screens/main/main_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'main.dart';
// import 'package:flutter/material.dart';
//
// class Registration extends StatefulWidget {
//   static const String id = "Registration";
//
//   @override
//   _RegistrationState createState() => _RegistrationState();
// }
//
// class _RegistrationState extends State<Registration> {
//   String email = "";
//   String password = "";
//   String username = '';
//   final FirebaseAuth_aut = FirebaseAuth.instance;
//
//   Future<void> registerUser() async {
//     final user = (FirebaseAuth_aut.createUserWithEmailAndPassword(
//             email: email, password: password))
//         .then((value)  {
//           print('success + $value');
//         })
//         .catchError((onError) {
//       print("Error is $onError");
//     });
//     Navigator.pushReplacementNamed(context, MainScreen.id);
//   }
//
//   final _key = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Medical equipment maintenance"),
//       ),
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
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'This field can\'t be empty';
//                 }
//                 return null;
//               },
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
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'This field can\'t be empty';
//                 }
//                 return null;
//               },
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
//               if (_key.currentState!.validate()) {
//                 await registerUser();
//               }
//             }, "Regestrstion")
//           ],
//         ),
//       ),
//     );
//   }
// }
