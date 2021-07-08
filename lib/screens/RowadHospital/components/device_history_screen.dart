import 'dart:async';
import 'dart:html';

import 'package:admin/config/constants.dart';
import 'package:admin/controllers/department_controller.dart';
import 'package:admin/controllers/requests_controller.dart';
import 'package:admin/models/reqest.dart';
import 'package:admin/screens/RowadHospital/components/recent_files.dart';
import 'package:admin/screens/main/components/confirm_AlertDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:admin/responsive.dart';

class DeviceHistoryScreen extends StatefulWidget {
  final departmentID;
  final deviceID;
  final deviceName;
  DeviceHistoryScreen(
      {@required this.departmentID,
      @required this.deviceID,
      @required this.deviceName});
  @override
  _DeviceHistoryScreenState createState() => _DeviceHistoryScreenState();
}

class _DeviceHistoryScreenState extends State<DeviceHistoryScreen> {
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  List<Request> deviceRequests = [];
  List<Request> recentRequests = [];
  List<Request> oldRequests = [];

  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.deviceName ?? "hospital system",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search), onPressed: () {})
        // ],
        centerTitle: true,
        elevation: 20,
      ),
      body: Consumer<DepartmentController>(
          builder: (context, departmentController, child) {
        return SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  //gridDelegate:
                  // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                  children: <Widget>[
                    // Image.asset('images/done.jpg'),
                    Container(
                      // width: 400,
                      height: 400,
                      child: Image.network(
                        departmentController.departmentDevices
                            .firstWhere(
                                (element) => element.id == widget.deviceID)
                            .image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    /* SizedBox(
                  height: 20.0,
                ),*/
                    Text(
                      widget.deviceName ?? "hospital system",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                      ),
                    ),

                    SizedBox(
                      height: 50.0,
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () => _launchURL(departmentController
                            .departmentDevices
                            .firstWhere(
                                (element) => element.id == widget.deviceID)
                            .manual!),
                        child: Text('service manual'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('requests').orderBy("timestamp", descending: true)
                        .where("device_id", isEqualTo: widget.deviceID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(child: Text('please try again later'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      // print("length ${snapshot.data!.docs.length}");
                      deviceRequests = [];
                      snapshot.data!.docs
                          .where((element) =>
                              element.data()['device_id'] == widget.deviceID)
                          .forEach((element) {
                        if (element.exists) {
                          deviceRequests.add(Request.fromSnap(element));
                        }
                      });

                      // print("device ${deviceRequests[0].response}");
                      recentRequests = deviceRequests
                          .where((element) => element.response!.trim() == "0")
                          .toList();

                      oldRequests = deviceRequests
                          .where((element) => element.response!.trim() != "0")
                          .toList();
                      // recentRequests.forEach((element) {
                      //   print(element.state);
                      // });
                      // print(oldRequests.length);
                      return deviceRequests.isEmpty
                          ? Center(
                              child: Text("No requests"),
                            )
                          : Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  recentRequests.isEmpty
                                      ? Container()
                                      : Expanded(
                                          child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  // color: Colors.grey,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Recent Requests",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  child: DataTable2(
                                                      columnSpacing:
                                                          defaultPadding,
                                                      columns: dataColumn,
                                                      rows: List.generate(
                                                          recentRequests.length,
                                                          (index) =>
                                                              recentRequestRow(
                                                                  recentRequests[
                                                                      index]))),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  oldRequests.isEmpty
                                      ? Container()
                                      : Expanded(
                                          child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  // color: Colors.grey,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Old Requests",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  child: DataTable2(
                                                      columnSpacing:
                                                          defaultPadding,
                                                      columns: dataColumn,
                                                      rows: List.generate(
                                                          oldRequests.length,
                                                          (index) =>
                                                              recentRequestRow(
                                                                  oldRequests[
                                                                      index]))),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                ],
                              ),
                            );
                    }),
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
    print(widget.deviceID);
  }

  DataRow recentRequestRow(Request request) {
    final f = new DateFormat('dd-MM-yyyy  hh:mm');

    return DataRow(
      cells: [
        DataCell(
          FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                request.deviceName!,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ),
        DataCell(
          FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                request.departmentName!,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ),
        DataCell(
          FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                request.message!,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ),
        DataCell(FittedBox(
          fit: BoxFit.contain,
          child: Text(
            f.format(request.timestamp!.toDate()),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(DropdownButton(
          hint: Text("Select status"),
          isExpanded: true,
          // items: status.values.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
          items: status.entries
              .map((e) => DropdownMenuItem(
                    child: Text(e.value),
                    value: e.key.toString(),
                  ))
              .toList(),
          onChanged: (val) async {
            if (await confirmAlertDialog(context)) {
              setState(() {
                request.state = val.toString();
                RequestsController.updateRequestStatus(
                    request.id!, val.toString());
                print(val);
              });
            }
          },
          value: request.state.toString().trim(),
        )),
      ],
    );
  }

  // DataRow oldRequestRow(Request request) {
  //   final f = new DateFormat('dd-MM-yyyy  hh:mm');
  //
  //   return DataRow(
  //     cells: [
  //       DataCell(
  //         Row(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
  //               child: Text(
  //                 request.message!,
  //                 softWrap: true,
  //                 overflow: TextOverflow.ellipsis,
  //                 maxLines: 2,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       DataCell(Text(
  //         f.format(request.timestamp!.toDate()),
  //         softWrap: true,
  //         overflow: TextOverflow.ellipsis,
  //         maxLines: 2,
  //       )),
  //       DataCell(Text(
  //         RequestsController.convertStateCodeToTitle(request.state.toString().trim()),
  //         softWrap: true,
  //         overflow: TextOverflow.ellipsis,
  //         maxLines: 2,
  //       ),),
  //     ],
  //   );
  // }

}
