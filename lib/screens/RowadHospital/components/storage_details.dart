import 'package:admin/controllers/department_controller.dart';
import 'package:admin/models/reqest.dart';
import 'package:admin/screens/RowadHospital/department_requests_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  List<Request> requests = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('requests').snapshots(),
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
          requests = [];
          snapshot.data!.docs.forEach((element) {
            if (element.exists) {
              requests.add(Request.fromSnap(element));
            }
          });
          return Consumer<DepartmentController>(
              builder: (context, departmentController, child) {
            return departmentController.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : departmentController.departments.isEmpty
                    ? Container()
                    : Container(
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Department Performance",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: defaultPadding),
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    departmentController.departments.length,
                                itemBuilder: (context, index) =>
                                    InkWell(
                                      onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DepartmentRequestsScreen(departmentController.departments[index]))),
                                      child: StorageInfoCard(
                                  title: departmentController
                                        .departments[index].name!,
                                  numOfFiles: requests
                                        .where((element) =>
                                            element.departmentID ==
                                            departmentController
                                                .departments[index].id)
                                        .length,
                                ),
                                    ),
                              ),
                              // ListView(
                              //   children: [StorageInfoCard(
                              //     title: "OR",
                              //     numOfFiles: 1328,
                              //   ),
                              //     StorageInfoCard(
                              //       title: "Cardiology",
                              //       numOfFiles: 1328,
                              //     ),
                              //     StorageInfoCard(
                              //       title: "ICU",
                              //       numOfFiles: 1328,
                              //     ),
                              //     StorageInfoCard(
                              //       title: "Radiology",
                              //       numOfFiles: 140,
                              //     ),StorageInfoCard(
                              //       title: "OR",
                              //       numOfFiles: 1328,
                              //     ),
                              //     StorageInfoCard(
                              //       title: "Cardiology",
                              //       numOfFiles: 1328,
                              //     ),
                              //     StorageInfoCard(
                              //       title: "ICU",
                              //       numOfFiles: 1328,
                              //     ),
                              //     StorageInfoCard(
                              //       title: "Radiology",
                              //       numOfFiles: 140,
                              //     ),],
                              // ),
                            ),
                          ],
                        ),
                      );
          });
        });
  }

}
