// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
   EditProfile({ Key? key }) : super(key: key);  
  bool isObsecurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
          // ignore: prefer_const_constructors
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
              SizedBox(height: 30),
              BuildTextField("Name", "Name"),
              BuildTextField("Email", "Email"),
              BuildTextField("Mobile Number", "Mobile Number"),
              SizedBox(height: 30),
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

