import 'package:admin/config/constants.dart';
import 'package:admin/controllers/requests_controller.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/models/reqest.dart';
import 'package:admin/screens/main/components/confirm_AlertDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class RecentFiles extends StatefulWidget {

  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  _RecentFilesState createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  List<Request> recent=[];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where("timestamp",
            isGreaterThan: Timestamp.fromDate(
                DateTime.now().subtract(Duration(days: 1))))
            .orderBy("timestamp", descending: true)
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
        recent = [];
        snapshot.data!.docs.forEach((element) {
          if (element.exists) {
            recent.add(Request.fromSnap(element));
          }
        });
        print(recent);

        return Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: recent.isEmpty
              ? Center(
            child: Text("No requests"),
          ):
          Container(
            // height: double.maxFinite,
            width: double.maxFinite,
            child: DataTable2(
                columnSpacing: defaultPadding,
                columns: dataColumn,
                rows: List.generate(
                    recent.length,
                        (index) => recentRequestRow(
                        recent[index]))),
          ),
        );
      }
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



