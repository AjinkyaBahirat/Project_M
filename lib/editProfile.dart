// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print, unused_local_variable

import 'dart:collection';
import 'dart:io';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project_m_new/userData.dart';

class EditProfile extends StatefulWidget {
  EditProfile({ Key? key }) : super(key: key);  

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userRef = FirebaseDatabase.instance.ref().child("Users");
  final picker = ImagePicker();
  String _imageFile='';

  final _auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;
  String name="",mobile="",email="",id="";
  String updatedName="",updatedMobile="",updatedEmail="";
  bool showSpinner = false;
  bool editname=false,editemail=false,editmobile=false;
  var url="";
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    if(user?.photoURL==null){
      url = "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_960_720.png";
    }
    else{
      url = "${user?.photoURL}";
    }
    data();
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile?.path as String;
    });
    uploadImage(context);
  }

  void data(){
    userRef.onValue.listen((event) {
      final data1 =  Map<String, dynamic>.from(event.snapshot.value as Map).forEach((key, value) { 
        final map =  Map<String,dynamic>.from(value as Map);
        if(map['Name']==user?.displayName.toString()){
          print(map['Name']);
          print(map['Email']);
          print(map['MobileNumber']);
          setState(() {
            name = map['Name'];
            email = map['Email'];
            mobile = map['MobileNumber'];
            id = map['Id'];
          });
        }
      });
    });
  }

Future uploadImage(BuildContext context) async{
  String? imgName = user?.displayName.toString();
  Reference reference = FirebaseStorage.instance.ref().child(imgName!);
  UploadTask task =  reference.putFile(File(_imageFile));
  var imgURL = await (await task).ref.getDownloadURL();
  print(imgURL);
  user?.updatePhotoURL(imgURL).whenComplete(() => {
    userRef.child(id).update({
      "ImageURL": imgURL,
    })
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: EdgeInsets.only(left: 15,top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
               pickImage();
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
                            image: _imageFile.isEmpty? NetworkImage(url) : FileImage(File(_imageFile)) as ImageProvider, 
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
                BuildTextField("Mobile Number", mobile),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: (){
                        Navigator.pop(context,true);
                      }, 
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
                      onPressed:() async{
                              setState(() {
                                showSpinner = true;
                              });
                              if(updatedName == '' && updatedMobile== '' && updatedEmail==''){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No Details to Update..!')));
                              }
                              else{
                                  if(editemail==true){
                                    print('Email Changed');
                                    try{
                                      userRef.child(id).update({
                                        'Email':updatedEmail,
                                      });

                                      user?.updateEmail(updatedEmail);
                                    }catch(e){
                                      print(e);
                                    }
                                  }
                                  if(editname==true){
                                    print('Name Changed');
                                    try{
                                      userRef.child(id).update({
                                        'Name':updatedName,
                                      });

                                      user?.updateDisplayName(updatedName);
                                    }catch(e){
                                      print(e);
                                    }
                                  }
                                  if(editmobile==true){
                                    print('Mobile Changed');
                                    try{
                                      userRef.child(id).update({
                                        'MobileNumber':updatedMobile,
                                      });
                                    }catch(e){
                                      print(e);
                                    }
                                  }
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            },
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
      ),
    );
  }

    Widget BuildTextField(String label, String inputtype){
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        onChanged: (value) {
          if(label=="Name"){
            setState(() {
              updatedName = value;
              editname = true;
            });
          }
          if(label=="Email"){
            setState(() {
              updatedEmail = value;
              editemail = true;
            });
          }
          if(label=="Mobile Number"){
            setState(() {
              updatedMobile = value;
              editmobile = true;
            });
          }
        },
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

