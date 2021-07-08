class MessageModel {
  String? senderId;
  String? nameDevice;
  String? location;
  String? dateTime;
  String? text;

  MessageModel({
    this.senderId='',
    this.nameDevice='',
    this.location='',
    this.dateTime='',
    this.text='',
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    nameDevice = json['nameDevice'];
    location = json['location'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'location': location,
      'nameDevice': location,
      'dateTime': dateTime,
      'text': text,
    };
  }
}