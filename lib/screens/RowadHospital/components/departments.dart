import 'package:admin/controllers/department_controller.dart';
import 'package:admin/firebase/firebasehelper.dart';
import 'package:admin/screens/RowadHospital/components/devices_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:provider/provider.dart';

class Departments extends StatefulWidget {
  static const String id = 'departments';
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Departments> {


  @override
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.currentUser!.email);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "hospital system",
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
      body: Consumer<DepartmentController>(
          builder: (context, departmentController, child) {

            return SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  child: SideMenu(),
                ),
              Expanded(
                flex: 5,
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: departmentController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : departmentController.departments.isEmpty?Center(child: Text("empty"),):GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10.0,
                                  crossAxisCount: 3),
                          padding: EdgeInsets.all(10.0),
                          itemCount: departmentController.departments.length,
                          itemBuilder: (context, index) => InkWell(
                            child: GridTile(
                              child: Image.network(
                                departmentController
                                    .departments[index].imageUrl!,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              footer: Container(
                                color: Colors.black.withOpacity(0.3),
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  departmentController
                                      .departments[index].name!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DevicesScreen(departmentController.departments[index].id)));
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DepartmentController>(context,listen: false).getDepartments();
  }
}
