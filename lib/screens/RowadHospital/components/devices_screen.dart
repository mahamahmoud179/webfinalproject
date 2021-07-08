import 'package:admin/controllers/department_controller.dart';
import 'package:admin/screens/RowadHospital/components/device_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:provider/provider.dart';

class DevicesScreen extends StatefulWidget {
  static const String id = 'DevicesScreen';
  final departmentID;
  DevicesScreen(this.departmentID);
  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "hospital system",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
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
                  height: double.infinity,
                  width: double.infinity,
                  child: departmentController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : departmentController.departmentDevices.isEmpty
                          ? Center(
                              child: Text("empty"),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10.0,
                                      crossAxisCount: 3),
                    padding: EdgeInsets.all(10.0),
                              itemCount:
                                  departmentController.departmentDevices.length,
                              itemBuilder: (context, index) => InkWell(
                                child: GridTile(
                                  child: Image.network(
                                    departmentController
                                        .departmentDevices[index].image!,
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
                                          .departmentDevices[index].name!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DeviceHistoryScreen(
                                            departmentID: widget.departmentID,
                                            deviceID: departmentController
                                                .departmentDevices[index].id,
                                            deviceName: departmentController
                                                .departmentDevices[index].name,
                                          )));
                                },
                              ),
                            ),
                  // InkWell(
                  //   child: GridTile(
                  //     child: Image.asset('images/Ventilator.jpg'),
                  //     footer: Container(
                  //       color: Colors.black.withOpacity(0.0005),
                  //       child: Text(
                  //         'Ventilator',
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w700),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed('ventilator');
                  //
                  //   },
                  // ),
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
    Provider.of<DepartmentController>(context, listen: false)
        .getDepartmentDevices(widget.departmentID);
    // print(widget.departmentID);
  }
}
