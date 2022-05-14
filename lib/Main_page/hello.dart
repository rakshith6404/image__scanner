import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardsShow extends StatefulWidget {
  const CardsShow({Key? key}) : super(key: key);

  @override
  State<CardsShow> createState() => _CardsShowState();
}

class _CardsShowState extends State<CardsShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
    );
  }
}

