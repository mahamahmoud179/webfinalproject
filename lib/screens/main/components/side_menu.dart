import 'package:admin/firebase/firebasehelper.dart';
import 'package:admin/landing_page.dart';
import 'package:admin/screens/RowadHospital/documents_screen.dart';
import 'package:admin/screens/RowadHospital/history_screen.dart';
import 'package:admin/screens/RowadHospital/notifications_screen.dart';
import 'package:admin/screens/RowadHospital/task_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:admin/screens/dashboard/components/departments.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/hospital logo.jpg"),
          ),
          DrawerListTile(
            title: "Home",
            iconData: Icons.home_outlined,
            press: () {
              Navigator.of(context).pushNamed(MainScreen.id);
            },
          ),
          DrawerListTile(
            title: "Departments",
            iconData: Icons.dashboard_outlined,
            press: () {
              Navigator.of(context).pushNamed('departments');
            },
          ),
          DrawerListTile(
            title: "Task",
            iconData: Icons.work_outline,
            press: ()=>Navigator.of(context).pushNamed(TaskScreen.id),
          ),
          DrawerListTile(
            title: "Documents",
            iconData: Icons.insert_drive_file_outlined,
            press: ()=>Navigator.of(context).pushNamed(DocumentsScreen.id),
          ),
          DrawerListTile(
            title: "History",
            iconData: Icons.history_edu_outlined,
            press: ()=>Navigator.of(context).pushNamed(HistoryScreen.id),
          ),
          DrawerListTile(
            title: "Notifications",
            iconData: Icons.notifications_none_outlined,
            press: ()=>Navigator.of(context).pushNamed(NotificationsScreen.id),
          ),

          DrawerListTile(
            title: "Chats",
            iconData: Icons.chat_outlined,
            press: () {
              Navigator.of(context).pushNamed('Chatscreen');
            },
          ),
          SizedBox(height: 30.0,),
          DrawerListTile(
            title: "SIGN OUT",
            iconData: Icons.person_outline,
            press: ()async{
              await signOut();
              Navigator.of(context).pushNamed(LandingPage.id);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.iconData,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(iconData,color: Colors.white54,),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
