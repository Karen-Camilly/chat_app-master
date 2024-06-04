// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'main.dart'; // Adicionando o import para o pacote supabase_auth_ui

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  Future<void> _googleSignIn(BuildContext context) async {
    const webClientId =
        '25014520087-jrp0podtr1gs4i15f7ih7glfrmiru9dd.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: webClientId,
    );
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Alerta de Segurança'),
              content: Text(
                  'ID Token não liberado devido a circunstâncias de segurança do site!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      // Redirecionar para a página de mensagens após o login bem-sucedido
      Navigator.pushReplacementNamed(context, '/messages');
    } catch (error) {
      // Lidar com qualquer erro que possa ocorrer durante o login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: "E-mail", border: OutlineInputBorder()),
              ),
              SizedBox(height: 5),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password", border: OutlineInputBorder()),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                child: Text("SignIn"),
                onPressed: () => (context),
              ),
              TextButton(
                child: Text("New User"),
                onPressed: () => Navigator.pushNamed(context, '/signup'),
              ),
              ElevatedButton(
                onPressed: () => _googleSignIn(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/google_logo.png', height: 24.0),
                    SizedBox(width: 16.0),
                    Text('Sign in with Google',
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
