// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({super.key});

  final _txtMessage = TextEditingController();

  void sendMessage() {
    var message = {
      "message": _txtMessage.text,
      "date": DateTime.now(),
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "username": FirebaseAuth.instance.currentUser!.displayName,
    };

    FirebaseFirestore.instance.collection('messages').add(message);
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  var docs = snapshot.data!.docs;

                  return ListView(
                    reverse: true,
                    children: docs.map((doc) => Message(doc)).toList(),
                  );
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(4),
                  child: TextField(
                    controller: _txtMessage,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Digite sua mensagem..."),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () => sendMessage(),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> document;
  late Map<String, dynamic> doc;
  late String id;

  Message(this.document) {
    doc = document.data();
    id = document.id;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      background: Container(color: Colors.red),
      onDismissed: (_) => document.reference.delete(),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://upload.wikimedia.org/wikipedia/commons/d/d3/Robert_Downey%2C_Jr._2012.jpg'),
        ),
        title: Text(doc['message']),
        subtitle: Text(doc['username'] ?? ''),
        trailing: Text(DateFormat.jm().format(doc['date'].toDate())),
      ),
    );
  }
}
