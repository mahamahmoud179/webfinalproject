import 'package:admin/responsive.dart';
import 'package:admin/screens/RowadHospital/components/recent_files.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';


class TodayRequestsScreen extends StatefulWidget {
  static const String id = 'TodayRequestsScreen';
  @override
  _TodayRequestsScreenState createState() => _TodayRequestsScreenState();
}

class _TodayRequestsScreenState extends State<TodayRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasks",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search), onPressed: () {})
        // ],
        centerTitle: true,
        elevation: 20,
      ),
      drawer: SideMenu(),
      body: SafeArea(child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              child: SideMenu(),
            ),
          Expanded(flex: 5,child: Container(margin: EdgeInsets.all(20.0),child: RecentFiles())),
        ],
      )),
    );
  }
}
