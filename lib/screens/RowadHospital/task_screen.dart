import 'package:admin/config/constants.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/requests_controller.dart';
import 'package:admin/models/reqest.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/confirm_AlertDialog.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  static const String id = 'TaskScreen';
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Request> tasks = [];
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
      body: SafeArea(
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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('requests').where('response',isEqualTo: "0").orderBy("timestamp",descending: true)
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
                  tasks = [];
                  snapshot.data!.docs
                      .forEach((element) {
                    if (element.exists) {
                      tasks.add(Request.fromSnap(element));
                    }
                  });
                  return tasks.isEmpty?Center(
                    child: Text("No requests"),
                  ):Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    margin: EdgeInsets.all(10.0),
                    child: Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.black12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "NUM OF Tasks :",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        SizedBox(width: 40.0,),
                                        Text(
                                          "${tasks.length}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                                          tasks.length,
                                              (index) =>
                                              recentRequestRow(
                                                  tasks[index]))),
                                ),
                              ),
                            ],
                          ),
                        ),),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
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
}
