import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imageScanner/Main_page/First_page.dart';
import 'package:imageScanner/Main_page/login_screen.dart';
import 'package:imageScanner/user/user_model.dart';

class HistoryPage extends StatefulWidget {


  //Getting the images uploaded from the cloud firestore
  String? userId;
  HistoryPage({Key? key, this.userId}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(widget.userId).collection("images").snapshots(),
        builder: (BuildContext context ,  AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if (!snapshot.hasData)
              {
                return (const Center(child: Text("No image Uploaded")));
              }
            else
              {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index)
                    {
                      String url = snapshot.data!.docs[index]['downloadURL'];
                      return Image.network(
                        url,
                       height: 300,
                       fit: BoxFit.cover,
                      );
                    });
              }
          }
      ),
    );
  }
}
