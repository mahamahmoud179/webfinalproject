import 'package:admin/models/Devices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentsModel {
  late String name;
  late String image;
  late List<DevicesModel> devices;
  late String id;

  DepartmentsModel.fromJson(Map<String, dynamic> json) {
    devices = [];
    image = json['image'] ?? '';
    id = json['id'] ?? '';
    json['devices '].forEach((element) {
      devices.add(DevicesModel.fromJson(element));
    });
    //1 2 3
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'id': id,
      'name': name,
      'devives ': devices,
    };
  }
}


class Department{
  String? id;
  String? name;
  String? imageUrl;
  List<Device> devices=[];


  Department.empty(){
    this.id="";
    this.name="";
    this.imageUrl="";
    this.devices=[];
  }

  Department.fromSnap(QueryDocumentSnapshot snap){
    Map data =snap.data();
    this.id= snap.id;
    this.name= data["name"] ?? "";
    this.imageUrl = data["image"] ?? "https://flutter.dev/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png";
    data["devices"] != null ? data["devices"].forEach((element) {
      this.devices.add(Device.fromSnap(element));
    }) : [];
    // date: snap.value["date"] != null
    //     ? DateTime.parse(snap.value["date"]) ?? DateTime.now()
    //     : DateTime.now(),
  }

  // Department({this.id, this.name, this.imageUrl,this.devices});

}
