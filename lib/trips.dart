import 'package:flutter/material.dart';

class Trips extends StatefulWidget {
  const Trips({Key? key}) : super(key: key);

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dream Tres')),
      body: Center(child: Text('Trips Page', style: TextStyle(fontSize: 40))),
    );
  }
}


// This is Trips Page Code