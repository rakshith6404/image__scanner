import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imageScanner/Main_page/First_page.dart';
import 'package:imageScanner/Main_page/login_screen.dart';
import 'package:imageScanner/user/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final _formKey = GlobalKey<FormState>();
  @override


  void initState(){
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body:Center(
        child:  Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 100, 60)),
            Image.asset("assets/ninja_avatar.png",height: 300),
            Container(
              padding: EdgeInsets.all(50),
              child: Text("${loggedInUser.userName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36)),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(180,50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36))
                ),
                onPressed: (){logOut(context);},
              child: Column(
                children: <Widget> [
                  Icon(Icons.logout),
                  Text("Log Out",style: TextStyle(fontSize: 20),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //logout functioning
  Future<void> logOut(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

}



