import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/signup.dart';
import 'chat.dart';
import 'main.dart';
import 'Page.dart';
import 'login.dart';
import 'signup.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainPage(),
    );
  }
}

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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomePage()));
              } else {
                return signin();
              }
            })));
  }
}

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: Image(image: AssetImage('images/avatar/connect2.jpg'))),
            SizedBox(height: 35),
            Container(
                padding: EdgeInsets.only(right: 200),
                child: Text(
                  "",
                  style: TextStyle(
                    color: Color.fromARGB(255, 73, 43, 7),
                    fontSize: 25,
                    decoration: TextDecoration.none,
                  ),
                )),
            SizedBox(height: 25),
            Container(
              width: 380,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email or phone number',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 380,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 0.0),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 35, 152, 194),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                )),
            SizedBox(height: 60),
            Container(
                width: 120,
                height: 70,
                child: ElevatedButton(
                    onPressed: SignIn,
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 99, 178, 223),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18), // <-- Radius
                      ),
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                      ),
                    ))),
            SizedBox(height: 40),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 75),
                  child: Text(
                    'New user?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 73, 43, 7),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => signup()));
                    },
                    child: Text(
                      "Create an account",
                      style: TextStyle(
                        color: Color.fromARGB(255, 35, 152, 194),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future SignIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
