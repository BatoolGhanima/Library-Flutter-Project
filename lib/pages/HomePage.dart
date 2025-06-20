import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:library_app/components/HomeComponent.dart';
import 'package:library_app/pages/BookListPage.dart';
import 'package:library_app/components/BookListView.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int index = 0;
  List<Widget> list = [Homecomponent(), 
  BookListPage()];
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
     drawer: Drawer(
      shadowColor: Colors.brown,
        backgroundColor: Color(0xFFE4C59E),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFAF8260)),
              child: ListView(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFFE4C59E),
                      ),
                      SizedBox(width: 150),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit, color: Color(0xFF5C260D)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Kenana Jarroud\nkenana@gmail.com",
                    style: TextStyle(
                      color: Color(0xFF5C260D),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "settings",
                style: TextStyle(color: Color(0xFF5C260D)),
              ),
              leading: Icon(Icons.settings, color: Color(0xFFAF8260)),
            ),
            Divider(color: Color(0xFFAF8260), thickness: 0.5),
            ListTile(
              title: Text("Theme", style: TextStyle(color: Color(0xFF5C260D))),
              leading: Icon(Icons.brightness_6, color: Color(0xFFAF8260)),
            ),
            Divider(color: Color(0xFFAF8260), thickness: 0.5),
            ListTile(
              title: Text(
                "Language",
                style: TextStyle(color: Color(0xFF5C260D)),
              ),
              leading: Icon(Icons.language, color: Color(0xFFAF8260)),
            ),
            Divider(color: Color(0xFFAF8260), thickness: 0.5),
            ListTile(
              title: Text("Logout", style: TextStyle(color: Color(0xFF5C260D))),
              leading: Icon(Icons.logout, color: Color(0xFFAF8260)),
            ),
          ],
        ),
      ),
  

      backgroundColor: Color(0xFFFFE3BF),
      body: Stack(
        
        
        
        children: [
           Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bookBackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
           BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0)), // تحتاج لوجود Container هنا لتفعيل الضبابية
          ),

          
          
          list[index]]),
      
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
            icon: Icon(Icons.bookmark, color: Color(0xFFD1AE8D), size: 30),
            label: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.person, color: Color(0xFFD1AE8D), size: 30),
            label: "",
            
          ),
        ],
        backgroundColor: Color(0xFF5C260D),
      ),
    );
  }
}