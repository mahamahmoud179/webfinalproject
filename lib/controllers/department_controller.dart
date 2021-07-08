import 'package:admin/models/Devices.dart';
import 'package:admin/models/department.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DepartmentController extends ChangeNotifier {
  List<Department> departments = [];
  Department? selectedDepartment;
  bool isLoading = false;
  bool requestLoading = false;
  List<Device> departmentDevices=[];

  List<Device> allDevices=[];

  getDepartments() async {
    if(departments.isNotEmpty){
      return;
    }
      isLoading = true;
      notifyListeners();
      departments = [];

      await FirebaseFirestore.instance
          .collection("department")
          .get()
          .then((data) {
        data.docs.forEach((element) {
          // print(element.id);
          if (element.exists) {
            departments.add(Department.fromSnap(element));
          }
        });
      });
      getAllDevices();
      print(departments[0].devices[0].name);
      isLoading = false;
      notifyListeners();
    // }
  }

  getAllDevices(){
    allDevices=[];
    departments.forEach((element) {
      element.devices.forEach((e) {
        allDevices.add(e);
      });
    });
  }

  getDepartmentDevices(String departmentID)async{
    departmentDevices = [];
    if(departments.isEmpty)
      await getDepartments();

      departmentDevices = departments.firstWhere((element) => element.id==departmentID).devices;
      notifyListeners();


  }

  @override
  void dispose() {
    super.dispose();
  }
}
