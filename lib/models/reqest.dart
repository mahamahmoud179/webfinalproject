import 'package:admin/config/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class RequestsModel {
  String? state;
  String? image;
  String? device_id;
  String? timestamp;
  String? uId;
  String? notes;
  String? messege;
  String? department_id;
  String? id;
  String? engineer_id;
  String? device_name;
  String? department_name;

  RequestsModel({
    this.image = '',
    this.uId = '',
    this.state = '',
    this. device_id = '',
   this. timestamp = '',
   this. engineer_id = '',
    this. notes = '',
    this. messege = '',
    this. department_id = '',
   this. id = '',
    this.device_name,
    this.department_name,



  });

  RequestsModel.fromJson(Map<String, dynamic> json) {
  image = json['image'] ?? '';
    uId = json['uId'] ?? '';
    device_id = json['device_id '] ?? '';
    state = json['state'] ?? '';
    engineer_id = json['engineer_id'] ?? '';
    notes = json['notes'] ?? '';
    department_id = json['department_id'] ?? '';
    id = json['id'] ?? '';

  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'uId': uId,
      'state': state,
      'device_id ': device_id,
      'engineer_id ': engineer_id,
      'notes ': notes,
      'messege ': messege,
      'department_id ': department_id,
      'id ': id,


    };
  }
}


class Request {
  String? id;
  String? departmentID;
  String? deviceID;
  String? engineerID;
  Timestamp? timestamp;
  String? senderID;
  String? response;
  String? message;
  String? state;
  String? deviceName;
  String? departmentName;



  Request({
    this.id= '',
    this.deviceID="",
    this.departmentID="",
    this.message="",
    this.response="0",
    this.engineerID="",
    this.senderID="",
    this.state="",
    this.timestamp,
    this.deviceName,
    this.departmentName,
  });


  Request.fromSnap(QueryDocumentSnapshot snap){
    Map data =snap.data();
    this.id= snap.id;
    this.departmentID = data["department_id"] ?? "";
    this.deviceID = data["device_id"]??"";
    this.deviceID = data["device_id"]??"";
    this.engineerID = data["engineer_id"]??"";
    this.message = data["message"] !=null ? data["message"].isNotEmpty ?data["message"]:"There is a problem":"There is a problem";
    this.response = data["response"] !=null ? data["response"].isNotEmpty ?data["response"]:"0":"0";
    this.senderID = data["sender_id"]??"";
    this.state = data["state"] !=null ? data["state"].isNotEmpty ? status.containsKey(data["state"])?data["state"]:"0":"0":"0";
    this.timestamp = data["timestamp"]??Timestamp.now();
    deviceName = data["device_name"] !=null ? data["device_name"].isNotEmpty ?data["device_name"]:"UNKNOWN":"UNKNOWN";
    departmentName = data["department_name"] !=null ? data["department_name"].isNotEmpty ?data["department_name"]:"UNKNOWN":"UNKNOWN";

  }
}
