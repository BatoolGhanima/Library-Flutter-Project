import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/pages/BookListPage.dart';
import 'package:library_app/pages/HomePage.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
    textTheme: GoogleFonts.dynaPuffTextTheme(),
  ),
      title: 'Library App',
     home: Homepage(),
     debugShowCheckedModeBanner: false,
    );
  }
}
