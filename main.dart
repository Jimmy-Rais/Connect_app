import 'dart:ui';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'login.dart';
import 'signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Page.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:firebase_database/firebase_database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Connect",
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: (() => Scaffold.of(context).openDrawer()),
            icon: const Icon(
              Icons.menu,
              size: 30,
              color: Colors.black,
            ),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
                height: 320,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 99, 178, 223),
                    ),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 2, right: 50),
                            child: Row(children: [
                              Text(
                                "User : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'Jimmy Rais',
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    speed: const Duration(milliseconds: 200),
                                  ),
                                ],
                              ),
                            ])),
                        Container(
                            padding: EdgeInsets.all(27),
                            child: AvatarGlow(
                              startDelay: Duration(milliseconds: 1000),
                              glowColor: Color.fromARGB(255, 194, 14, 14),
                              endRadius: 80,
                              showTwoGlows: true,
                              repeatPauseDuration: Duration(milliseconds: 100),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    AssetImage('images/avatar/Pierre.jpg'),
                              ),
                            ))
                      ],
                    ))),
            ListTile(
              leading: Icon(
                Icons.contact_page_rounded,
              ),
              title: const Text('Contacts', style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              leading: Icon(
                Icons.group,
              ),
              title: const Text('Groups', style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              leading: Icon(
                Icons.remove_red_eye,
              ),
              title:
                  const Text('Online Contacts', style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              leading: Icon(
                Icons.call,
              ),
              title:
                  const Text('Calls History', style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              leading: Icon(
                Icons.filter_1_outlined,
              ),
              title: const Text('Stories', style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
              ),
              title: const Text('Settings', style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              onTap: () {
                showPlatformDialog(
                    context: context,
                    builder: ((context) => BasicDialogAlert(
                          title: Text('Log out?'),
                          content: Text('Action cannot be undone'),
                          actions: <Widget>[
                            BasicDialogAction(
                              title: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            BasicDialogAction(
                              title: Text('Yes'),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => login()));
                                FirebaseAuth.instance.signOut();
                              },
                            ),
                          ],
                        )));
              },
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.logout_outlined, size: 25),
              ),
              title: const Text('Log out', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 60),
            ListTile(
              title: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Jimmy Rais',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          FavoriteSection(),
          Expanded(
            child: MessageSection(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromARGB(255, 99, 178, 223),
        child: Icon(
          Icons.edit,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MenuSection extends StatelessWidget {
  final List MenuItems = ["Messages", "Statut", "Online", "Call", "Group"];
  MenuSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: MenuItems.map((items) {
              return Container(
                margin: EdgeInsets.only(right: 55),
                child: Text(
                  items,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class FavoriteSection extends StatelessWidget {
  final List FavoriteContacts = [
    {
      'name': 'Jim',
      'profile': 'images/avatar/Jim.jpg',
    },
    {
      'name': 'Joe',
      'profile': 'images/avatar/Joe.jpg',
    },
    {
      'name': 'Dan',
      'profile': 'images/avatar/Dan.jpg',
    },
    {
      'name': 'Shaloe',
      'profile': 'images/avatar/Amanda.jpg',
    },
    {
      'name': 'Lucas',
      'profile': 'images/avatar/Lucas.jpg',
    },
    {
      'name': 'Louise',
      'profile': 'images/avatar/Louise.jpg',
    },
    {
      'name': 'Arnold',
      'profile': 'images/avatar/Arnold.jpg',
    },
  ];
  FavoriteSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15), //Contenu à la verticale
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 99, 178, 223),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(-20),
            bottomRight: Radius.circular(-20),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "STORIES",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 23,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: FavoriteContacts.map((fav) {
                  return Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(fav['profile']),
                          ),
                        ),
                        SizedBox(
                            height: 6), // Create space between these two parts
                        Text(
                          fav['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageSection extends StatelessWidget {
  final List Messages = [
    {
      'sendername': 'Jim',
      'senderprofile': 'images/avatar/Jim.jpg',
      'message': 'Hello',
      'unread': 0,
      'date': '8:34',
    },
    {
      'sendername': 'Amanda',
      'senderprofile': 'images/avatar/Amanda.jpg',
      'message': 'Salut',
      'unread': 2,
      'date': '12:20',
    },
    {
      'sendername': 'Gloire',
      'senderprofile': 'images/avatar/Amanda.jpg',
      'message': 'Bonjour',
      'unread': 1,
      'date': '19:00',
    },
    {
      'sendername': 'Erick',
      'senderprofile': 'images/avatar/Erick.jpg',
      'message': 'Je suis là!',
      'unread': 4,
      'date': '19:05',
    },
    {
      'sendername': 'Michel',
      'senderprofile': 'images/avatar/Michel.jpg',
      'message': 'On se voit demain',
      'unread': 2,
      'date': '20:12',
    },
    {
      'sendername': 'Lucas',
      'senderprofile': 'images/avatar/Lucas.jpg',
      'message': 'Bonsoir!',
      'unread': 0,
      'date': '20:22',
    },
    {
      'sendername': 'Jordan',
      'senderprofile': 'images/avatar/Jordan.jpg',
      'message': 'Tu vas bien?',
      'unread': 1,
      'date': '20:34',
    },
    {
      'sendername': 'Louise',
      'senderprofile': 'images/avatar/Louise.jpg',
      'message': 'Hey',
      'unread': 3,
      'date': '21:00',
    },
    {
      'sendername': 'Pierre',
      'senderprofile': 'images/avatar/Pierre.jpg',
      'message': 'Bonsoir',
      'unread': 5,
      'date': '21:34',
    },
    {
      'sendername': 'Claire',
      'senderprofile': 'images/avatar/Claire.jpg',
      'message': 'Salut',
      'unread': 2,
      'date': '22:00',
    },
  ];
  MessageSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: Messages.map((Mess) {
          // Click detection
          return InkWell(
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => chatPage())),
            },
            splashColor: Color.fromARGB(255, 99, 178, 223),
            child: Container(
              padding: EdgeInsets.only(left: 7, right: 10, top: 15),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(Mess['senderprofile']),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        // Max Space between row elements
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            // Start from the right
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Mess['sendername'],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // Line return
                              Wrap(
                                children: [
                                  Text(
                                    Mess['message'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(Mess['date']),
                              SizedBox(height: 8),
                              Mess['unread'] != 0
                                  ? Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 99, 178, 223),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        Mess['unread'].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Separating line
                      Container(
                        height: 1.2,
                        color: Colors.grey,
                      )
                    ],
                  ))
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
// Chat Page
