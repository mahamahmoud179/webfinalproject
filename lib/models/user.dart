List<String> types = ['nurse', 'doctor', 'engineer'];
                  //    0         1           2

class UserModel {
  String? name;
  String? email;
   String? phone;
  String? uId;
  int? type;

  UserModel({
    this.email = '',
    this.uId = '',
    this.name = '',
    this.phone = '',
    this.type =0,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? '';
    uId = json['uId'] ?? '';
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uId': uId,
      'name': name,
    };
  }
}
