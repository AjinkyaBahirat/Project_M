// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_m_new/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;
  var url="";
  ImagePicker picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(user!.email);
    if(user?.photoURL==null){
      url = "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_960_720.png";
    }
    else{
      url = "${user?.photoURL}";
    }
  }

  
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlueAccent, Colors.blueAccent]
              )
            ),
            child: Container(
              width: double.infinity,
              height: 200.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async{
                      
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          url,
                        ),
                        radius: 50.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("${user?.displayName}",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("${user?.email}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: double.infinity,
            height: 300.0,
            child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("Update Profile", style: TextStyle( fontFamily: 'Montserrat', fontSize: 15.0),textAlign: TextAlign.center,),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.group),
                    title: Text("Friend List", style: TextStyle( fontFamily: 'Montserrat', fontSize: 15.0),textAlign: TextAlign.center,),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 300.00,

            child: RaisedButton(
              onPressed: (){
                _auth.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('SuccessFully Loged Out...!')));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyHomePage()));
                
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)
              ),
              elevation: 0.0,
                padding: const EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.lightBlueAccent,Colors.lightBlueAccent]
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: const Text("Log Out",
                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                  ),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}


// This is Profile Page Code