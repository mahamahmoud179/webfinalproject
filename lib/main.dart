import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/controllers/department_controller.dart';
import 'package:admin/landing_page.dart';
import 'package:admin/login.dart';
import 'package:admin/registration.dart';
import 'package:admin/screens/RowadHospital/components/devices_screen.dart';
import 'package:admin/screens/RowadHospital/components/device_history_screen.dart';
import 'package:admin/screens/RowadHospital/components/departments.dart';
import 'package:admin/screens/RowadHospital/documents_screen.dart';
import 'package:admin/screens/RowadHospital/history_screen.dart';
import 'package:admin/screens/RowadHospital/notifications_screen.dart';
import 'package:admin/screens/RowadHospital/task_screen.dart';
import 'package:admin/screens/RowadHospital/today_requests_screen.dart';
import 'package:admin/screens/main/auth_screen.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DepartmentController(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Admin Panel',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white),
            canvasColor: secondaryColor,
          ),
          // home: MainScreen(),
          initialRoute: LandingPage.id,
          routes: {
            // MyHomepage.id: (context) => MyHomepage(),
            // Registration.id: (context) => Registration(),
            // Login.id: (context) => Login(),
            MainScreen.id: (context) => MainScreen(),
            Departments.id: (context) =>Departments(),
            TaskScreen.id: (context) => TaskScreen(),
            HistoryScreen.id: (context) =>HistoryScreen(),
            DocumentsScreen.id: (context) =>DocumentsScreen(),
            NotificationsScreen.id: (context) =>NotificationsScreen(),
            TodayRequestsScreen.id:(context)=>TodayRequestsScreen(),
            AuthScreen.id: (context)=>AuthScreen(),
            LandingPage.id: (context)=>LandingPage(),
            // OR.id: (context) =>OR(),
            // DeviceHistoryScreen.id: (context) =>DeviceHistoryScreen()


          }),
    );
  }
}
// class MyHomepage extends StatelessWidget {
//   static const String id = "Homescreen";
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       // drawer: SideMenu(),
//         body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Hero(
//               tag: 'logo',
//               child: Container(
//                 width: 200,
//                 child: Image.asset("assets/images/logo.png",scale: 1.5),
//               ),
//             ),
//             Text(
//               'Medical equipment maintenance',
//               style: TextStyle(fontSize: 40),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 50,
//         ),
//         CustomButton(() {
//           Navigator.of(context).pushNamed(Login.id);
//         }, 'Login'),
//         SizedBox(
//           height: 10,
//         ),
//         CustomButton(() {
//           Navigator.of(context).pushNamed(Registration.id);
//         }, 'Register')
//       ],
//     ));
//   }
// }
// class CustomButton extends StatelessWidget {
//   final VoidCallback callback;
//   final String text;
//
//   const CustomButton(this.callback, this.text);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Material(
//         color: Colors.black26,
//         elevation: 6,
//         borderRadius: BorderRadius.circular(30),
//         child: MaterialButton(
//           onPressed: callback,
//           minWidth: 200,
//           height: 45,
//           child: Text(text),
//         ),
//       ),
//     );
//   }
// }
