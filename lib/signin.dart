import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'main.dart';
import 'Page.dart';
import 'login.dart';

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
      body: Column(
        children: [
          Container(
              child: Image(image: AssetImage('images/avatar/connect2.jpg'))),
          SizedBox(height: 35),
          Container(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                "Sign in",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
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
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(18)),
              ),
            ),
          ),
          SizedBox(height: 25),
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
          SizedBox(height: 18),
          TextButton(
              onPressed: () {},
              child: Text(
                "Forgot password?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                ),
              )),
          Expanded(
              child: TextButton(
                  onPressed: SignIn,
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Color.fromARGB(255, 99, 178, 223),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )))
        ],
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
