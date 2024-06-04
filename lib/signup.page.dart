// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final _txtName = TextEditingController();
  final _txtEmail = TextEditingController();
  final _txtPassword = TextEditingController();

  final _auth = FirebaseAuth.instance;

  Future<void> _signUp(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _txtEmail.text,
        password: _txtPassword.text,
      );

      await userCredential.user!.updateDisplayName(_txtName.text);
      

      Navigator.pushReplacementNamed(context, '/messages');
    } on FirebaseAuthException catch (ex) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ex.message!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 240,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: _txtName,
                decoration: InputDecoration(
                    hintText: "Name", border: OutlineInputBorder()),
              ),
              TextField(
                controller: _txtEmail,
                decoration: InputDecoration(
                    hintText: "E-mail", border: OutlineInputBorder()),
              ),
              TextField(
                controller: _txtPassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password", border: OutlineInputBorder()),
              ),
              ElevatedButton(
                child: Text("SignUp"),
                onPressed: () => _signUp(context),
              ),
              TextButton(
                child: Text("Back to Login"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
