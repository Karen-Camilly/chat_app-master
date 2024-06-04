import 'package:flutter/material.dart';

import 'signin.page.dart';
import 'messages.page.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        routes: {
          "/signin": (context) => SignInPage(),
          "/messages": (context) => MessagesPage(),
        },
        initialRoute: '/signin');
  }
}
