import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chatapp.dart';

const options = FirebaseOptions(
    apiKey: "AIzaSyBKJzao81MajTsINsvKfRbwxIBXR2DEnxA",
    authDomain: "chatapp-e0b23.firebaseapp.com",
    projectId: "chatapp-e0b23",
    storageBucket: "chatapp-e0b23.appspot.com",
    messagingSenderId: "303242862710",
    appId: "1:303242862710:web:2a2f27aee6670f1269ff57");

const supabaseUrl = 'https://avpyfkkgokkiwkwoaarq.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF2cHlma2tnb2traXdrd29hYXJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY0MDc5NTYsImV4cCI6MjAzMTk4Mzk1Nn0.Y-S1PISEt1Z6IRzIRqk165oc7IIBKkNOLFvjUE2BODU';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const ChatApp());
}

final supabase = Supabase.instance.client;
