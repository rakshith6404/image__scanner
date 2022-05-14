
import 'dart:io';
import 'package:imageScanner/Scan/Saving_to_contacts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Details extends StatefulWidget {
  String? text;
  XFile? images;
  Details({this.images,this.text});
  @override
  _DetailsState createState() => _DetailsState(images,text);
}

class _DetailsState extends State<Details> {

  XFile? images;
  String? text;
  _DetailsState(this.images,this.text);
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('Details'),
      ),
      body:Padding(
        padding: EdgeInsets.fromLTRB(5, 38, 5, 0),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Card(

              clipBehavior: Clip.antiAlias,
              color: Colors.blueGrey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
                child:
                Column(
                  children: [
                    SizedBox(height: 5),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(10,5, 15,15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(File(images!.path)),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(1, 10, 10, 1),
                    child: Text(
                      "Email: ${text}",style: TextStyle(fontSize: 10),textAlign: TextAlign.left,
                      ),
                    ),

                    ButtonBar(
                      alignment: MainAxisAlignment.center,

                      children: <Widget>[
                        TextButton(onPressed: (){}, child: Text("Details"),
                        )
                      ],
                    )

                  ],
                )
                //child: Image.file(File(images!.path)),
            )
          ),
        ),
      )


    );
  }


}
/*



import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imageScanner/Main_page/History.dart';
import 'package:imageScanner/Main_page/hello.dart';
import 'package:imageScanner/Main_page/First_page.dart';
import 'package:imageScanner/Main_page/login_screen.dart';
import 'package:imageScanner/Main_page/profile_page.dart';
import 'package:imageScanner/user/user_model.dart';

class Details extends StatefulWidget {
  //final String text;
  //Details(this.text);
  String? userId;
  Details({Key? key, this.userId}) : super(key: key);


  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").doc(widget.userId).collection("images").snapshots(),
            builder: (BuildContext context ,  AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError)
              {
                return Center(child: Text("Something Went Wrong....Please Try again"),);
              }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                  String url = snapshot.data!.docs[index]['downloadURL'];
                  String text = snapshot.data!.docs[index]['Email'];
                  return Card(
                    color: Colors.blueGrey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:<Widget> [
                          ListTile(
                          leading: Image.network(url ,fit: BoxFit.fill),
                            subtitle: Text("Text : ${text}"),
                          ),
                        ],
                      ),
                    );
                }
            );
          }
        ),

      )
    );
  }
}

 */



