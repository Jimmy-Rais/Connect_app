import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String userId;

  ChatScreen({required this.chatId, required this.userId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final DatabaseReference _messagesRef;
  late final TextEditingController _messageController;
  late Stream<Event> _messagesStream;

  @override
  void initState() {
    super.initState();
    _messagesRef = FirebaseDatabase.instance
        .reference()
        .child('chats')
        .child(widget.chatId)
        .child('messages');
    _messageController = TextEditingController();
    _messagesStream = _messagesRef.onValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<Event>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                Map<dynamic, dynamic>? messages = snapshot.data?.snapshot.value;
                if (messages == null) {
                  return Center(child: Text('No messages yet'));
                }
                List<Message> messageList = [];
                messages.forEach((key, value) {
                  messageList.add(Message.fromMap(value));
                });
                return ListView.builder(
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    Message message = messageList[index];
                    return ListTile(
                      title: Text(message.content),
                      subtitle: Text(message.senderId),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String content = _messageController.text.trim();
                    if (content.isNotEmpty) {
                      Message message = Message(
                        content: content,
                        senderId: widget.userId,
                      );
                      _messagesRef.push().set(message.toMap());
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String content;
  final String senderId;

  Message({required this.content, required this.senderId});

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'senderId': senderId,
    };
  }

  factory Message.fromMap(Map<dynamic, dynamic> map) {
    return Message(
      content: map['content'],
      senderId: map['senderId'],
    );
  }
}
