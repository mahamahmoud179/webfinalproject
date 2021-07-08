

import 'package:flutter/material.dart';

Map<String,String> status ={
  '0':"Waiting",
  "1":"Solved by engineer",
  "2":"Contacted with management",
};

List<DataColumn> dataColumn=[
  DataColumn(label: Text("Device")),
  DataColumn(label: Text("Department")),
  DataColumn(
    label: Text(
        "Description"),
  ),
  DataColumn(
    label: Text("Date"),
  ),
  DataColumn(
    label: Text("State"),
  ),

];


