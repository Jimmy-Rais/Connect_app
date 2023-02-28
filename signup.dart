import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/signin.dart';
import 'chat.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
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
            SizedBox(height: 150),
            Container(
                child: Text(
              "Create account",
              style: TextStyle(
                color: Color.fromARGB(255, 73, 43, 7),
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(height: 45),
            Container(
              //padding: EdgeInsets.only(left: 25),
              width: 380,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              width: 500,
              //padding: EdgeInsets.only(left: 25),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password_outlined),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 0.0),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
            SizedBox(height: 90),
            Container(
                child: Container(
                    height: 70,
                    width: 120,
                    child: ElevatedButton(
                        onPressed: SignUp,
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 99, 178, 223),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(18), // <-- Radius
                          ),
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        )))),
            SizedBox(height: 50),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 66),
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 73, 43, 7),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => signin()));
                    },
                    child: Text(
                      "Log in",
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

  Future SignUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
