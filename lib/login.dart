import 'dart:ui';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'main.dart';
import 'signup.dart';
import 'signin.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Image(image: AssetImage('images/avatar/connect.jpg')),
          ),
          SizedBox(height: 120),
          SizedBox(
            height: 80,
            width: 250,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signin()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 99, 178, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18), // <-- Radius
                  ),
                ),
                child: Text(
                  "SIGN IN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                )),
          ),
          SizedBox(height: 50),
          SizedBox(
            height: 80,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => signup()));
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 99, 178, 223),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18), // <-- Radius
                ),
              ),
              child: Text(
                "SIGN UP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          SizedBox(height: 100),
          Text(
            "Sign in with",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              SizedBox(width: 60),
              Container(
                child: Icon(
                  Icons.facebook_outlined,
                  color: Colors.white,
                  size: 70,
                ),
              ),
              SizedBox(width: 60),
              Container(
                  height: 70,
                  width: 70,
                  child: Image(image: AssetImage('images/avatar/google.jpg'))),
              SizedBox(width: 60),
              Container(
                  height: 80,
                  width: 80,
                  child:
                      Image(image: AssetImage('images/avatar/instagram.jpg'))),
            ],
          )
        ],
      ),
    );
  }
}
