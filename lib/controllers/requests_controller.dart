
import 'package:admin/config/constants.dart';
import 'package:admin/models/reqest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class RequestsController {

  static updateRequestStatus(String requestID,String status)async{
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(requestID)
          .update({'response':status=="0"?"0":"1",'state':"$status"});
    } catch (e) {
      print(e);
      return false;
    }
  }

  static convertStateCodeToTitle(String code){
    return status.containsKey(code)?status[code]:"UNKNOWN";
  }
}