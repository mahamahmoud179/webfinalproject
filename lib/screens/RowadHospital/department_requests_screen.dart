import 'package:admin/config/constants.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/requests_controller.dart';
import 'package:admin/models/department.dart';
import 'package:admin/models/reqest.dart';
import 'package:admin/screens/main/components/confirm_AlertDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DepartmentRequestsScreen extends StatefulWidget {
  final Department department;
  DepartmentRequestsScreen(this.department);
  @override
  _DepartmentRequestsScreenState createState() => _DepartmentRequestsScreenState();
}

class _DepartmentRequestsScreenState extends State<DepartmentRequestsScreen> {
  List<Request> requests = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.department.name!,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search), onPressed: () {})
        // ],
        centerTitle: true,
        elevation: 20,
      ),
      body: SafeArea(
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
                      widget.department.imageUrl!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  /* SizedBox(
                  height: 20.0,
                ),*/
                  Text(
                    widget.department.name ?? "hospital system",
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
                  Text(
                    "${widget.department.devices.length} Devices in this department",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
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
                      .where("department_id", isEqualTo: widget.department.id)
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
                    requests = [];
                    snapshot.data!.docs
                        .forEach((element) {
                      if (element.exists) {
                        requests.add(Request.fromSnap(element));
                      }
                    });
                    return requests.isEmpty
                        ? Center(
                      child: Text("No requests"),
                    )
                        : Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        children: [
                          requests.isEmpty
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
                                          "All Requests",
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
                                                requests.length,
                                                    (index) =>
                                                    recentRequestRow(
                                                        requests[
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
