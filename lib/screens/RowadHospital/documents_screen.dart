import 'package:admin/models/document.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class DocumentsScreen extends StatefulWidget {
  static const String id = 'DocumentsScreen';
  @override
  _DocumentsScreenState createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {

  List<Document> documents=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Documents",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search), onPressed: () {})
        // ],
        centerTitle: true,
        elevation: 20,
      ),
      drawer: SideMenu(),
      body: SafeArea(child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            Expanded(
              child: SideMenu(),
            ),
          Expanded(
            flex: 5,
            child: FutureBuilder<QuerySnapshot>(future: FirebaseFirestore.instance
                .collection("documents").get(),builder: (context,snapshot){
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('please try again later'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              documents = [];
              snapshot.data!.docs
                  .forEach((element) {
                if (element.exists) {
                  documents.add(Document.fromSnap(element));
                }
              });
              return Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: documents.isEmpty?Center(child: Text("Empty"),):GridView.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 3),
                  padding: EdgeInsets.all(10.0),
                  itemCount: documents.length,
                  itemBuilder: (context, index) => InkWell(
                    child: GridTile(
                      child: Image.network(
                        documents[index].image!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      footer: Container(
                        color: Colors.black.withOpacity(0.3),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          documents[index].title!,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onTap: () => _launchURL(documents[index].link!),
                  ),
                ),
              );
            }),
          ),
        ],
      ),),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
