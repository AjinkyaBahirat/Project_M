// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print, unused_local_variable

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_m_new/userData.dart';

class EditProfile extends StatefulWidget {
  EditProfile({ Key? key }) : super(key: key);  

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userRef = FirebaseDatabase.instance.ref().child("Users");

  final _auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;
  String name="",mobile="",email="",id="";
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    data();
  }

  void data()async{
    Query query = userRef.orderByChild("Name").equalTo(user?.displayName);
    DataSnapshot event = await query.get();
    Map map = event.children.first.value as Map;
    //print(map['Name']);
    setState(() {
      name = map['Name'];
      id = map['Id'];
      email = map['Email'];
      mobile = map['MobileNumber'];
    });
  }

  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, 
            color: Colors.white,
            ),
            onPressed: (){
              Navigator.pop(context,true);
            },
            ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15,top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4,color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          )
                        ],
                        shape: BoxShape.circle,
                        // ignore: prefer_const_constructors
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: const NetworkImage("https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_960_720.png") 
                          ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              BuildTextField("Name", name),
              BuildTextField("Email", email),
              BuildTextField("MobileNumber", mobile),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: (){}, 
                    child: Text("CANCEL",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    ),
                    ElevatedButton(
                    onPressed: (){}, 
                    child: Text("SAVE",style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    ),
                ],
              )
            ],
          ),
        ), 
        ),
    );
  }

    Widget BuildTextField(String label, String inputtype){
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: inputtype,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),

        ),
      ),
      );
  }
}

