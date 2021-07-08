

import 'package:cloud_firestore/cloud_firestore.dart';

const testImage ="https://firebasestorage.googleapis.com/v0/b/webapp1-ae7ec.appspot.com/o/ECG%20Monitor.jpg?alt=media&token=e6ac6d42-789b-4857-b5e6-ffe985c79a95";
const testLink = "https://firebasestorage.googleapis.com/v0/b/webapp1-ae7ec.appspot.com/o/Nihon%20Kohden%209010K%20Service%20Manual%20ECG.pdf?alt=media&token=cfda97c5-65d8-43d9-b631-1d4cbf3f63fc";
class Document{
  String? id;
  String? image;
  String? link;
  String? title;



  Document.empty(){
    this.id="";
    this.image="";
    this.link="";
    this.title="";
  }

  Document.fromSnap(QueryDocumentSnapshot snap){
    Map data =snap.data();
    this.id= snap.id;
    this.title= data["title"] ?? "";
    this.image = data["image"] !=null ? data["image"].isNotEmpty ?data["image"]:testImage:testImage;
    this.link =data["link"] !=null ? data["link"].isNotEmpty ?data["link"]:testLink:testLink;
    // date: snap.value["date"] != null
    //     ? DateTime.parse(snap.value["date"]) ?? DateTime.now()
    //     : DateTime.now(),
  }
}