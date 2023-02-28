import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'chat.dart';
import 'main.dart';
import 'signup.dart';
import 'signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mainPage extends StatelessWidget {
  const mainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.hasData) {
                return HomePage();
                MaterialPageRoute(builder: (context) => const HomePage());
              } else {
                return login();
              }
            })));
  }
}
