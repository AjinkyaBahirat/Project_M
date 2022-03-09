import 'package:flutter/material.dart';

class Comm extends StatefulWidget {
  const Comm({Key? key}) : super(key: key);

  @override
  State<Comm> createState() => _CommState();
}

class _CommState extends State<Comm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dream Tres')),
      body:
          Center(child: Text('Community Page', style: TextStyle(fontSize: 40))),
    );
  }
}


// This is Community Page Code