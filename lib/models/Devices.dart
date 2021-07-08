

List<String> types = ['nurse', 'doctor', 'engineer'];
                  //    0         1           2

class DevicesModel {
  String? name;
  String? image;
   String? manual;
  String? id;



  DevicesModel({
    this.image = '',
    this.id = '',
    this.name = '',
    this. manual = '',

  });

  DevicesModel.fromJson(Map<String, dynamic> json) {
  image = json['image'] ?? '';
    id = json['id'] ?? '';
    manual = json['manual '] ?? '';
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'deviceId': id,
      'name': name,
      'manual ': manual,


    };
  }
}


class Device{
  String? id;
  String? name;
  String? image;
  String? manual;
  String? qr;
  String? departmentID;

  Device.fromSnap(Map snap) {

    this.id= snap['id'];
    this.departmentID= snap['department_id']??"";
    this.name= snap["name"] ?? "";
    this.manual= snap["manual"] ?? "";
    this.qr = snap['qr']??"";
    this.image= snap["image"] ?? "https://flutter.dev/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png";
    // date: snap.value["date"] != null
    //     ? DateTime.parse(snap.value["date"]) ?? DateTime.now()
    //     : DateTime.now(),
  }

  convertToMap(Device data){
    return {
      "id":data.id??"",
      "name":data.name??"",
      "manual":data.manual??"",
      "qr":data.qr??"",
      "image":data.image??"",
    };
  }

  // Device({this.id, this.name, this.image,this.manual,this.qr});
}
