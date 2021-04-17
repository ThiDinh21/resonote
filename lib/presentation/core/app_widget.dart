import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resonote/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  final _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resonote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        accentColor: Colors.purple,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      home: FutureBuilder(
        // Initialize FlutterFire
        future: _fbApp,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Text('Something went wrong!');
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return SignInPage();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
