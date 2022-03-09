import 'package:flutter/material.dart';

class Addtrip extends StatefulWidget {
  Addtrip({Key? key}) : super(key: key);

  @override
  State<Addtrip> createState() => _AddtripState();
}

class _AddtripState extends State<Addtrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dream Tres')),
      body:
          Center(child: Text('Add Trip Page', style: TextStyle(fontSize: 40))),
    );
  }
}


// This is Add Trips Page Code
