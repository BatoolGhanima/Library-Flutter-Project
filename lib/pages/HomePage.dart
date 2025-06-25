import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:library_app/components/HomeComponent.dart';
import 'package:library_app/components/drawerUser.dart';
import 'package:library_app/pages/BookListPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/pages/PersonalPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int index = 0;
  List<Widget> list = [Homecomponent(), 
  BookListPage(),
  Personalpage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  
  iconTheme: IconThemeData(color: Colors.white , ),
  backgroundColor: Color(0xFF5C260D),
  title: Text(
    "LibBook",
    style: GoogleFonts.dynaPuff(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
     drawer: Draweruser(),
  

      
     body:list[index],

      
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home, color: Color(0xFFD1AE8D), size: 30),
            label: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.library_books, color: Color(0xFFD1AE8D), size: 30),
            label: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.person, color: Color(0xFFD1AE8D), size: 30),
            label: "",
            
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.bookmark, color: Color(0xFFD1AE8D), size: 30),
          //   label: "",
          // ),
          
        ],
        backgroundColor: Color(0xFF5C260D),
      ),
    );
  }
}