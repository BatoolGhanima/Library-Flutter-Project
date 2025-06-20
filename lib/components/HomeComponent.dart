import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/components/BookListView.dart';

class Homecomponent extends StatefulWidget {
  const Homecomponent({super.key});

  @override
  State<Homecomponent> createState() => _HomecomponentState();
}

class _HomecomponentState extends State<Homecomponent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  

      backgroundColor: Color(0xFFFFE3BF),
      body: ListView(
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Color(0xFF5C260D),
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25),topRight:Radius.circular(25),bottomRight:Radius.circular(25), ),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.arrow_back, color: Color(0xFFD1AE8D)),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Color(0xFFD1AE8D)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.search, color: Color(0xFFD1AE8D)),
                SizedBox(width: 10),
              ],
            ),
          ),
          

          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFFFE4C4),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 100, 70, 59),
                  blurRadius: 10,
                  offset: Offset(0, 1),
                ),
                
              ],
            ),
            margin: EdgeInsets.only(top: 10, left:25, bottom: 20, right:25),

            child: Center(
              child: Text(
                "  Welcome To My Library 📚\n  Your personal library, always with you.\n Easily organize, track, and explore your\n  book collection.\n\n  Add your favorite reads, manage your\n  progress, and keep notes, all in one place.\n\n  Start building your reading journey today!",
                style: TextStyle(fontSize: 16, color: Color(0xFF5C260D)),
              ),
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5C260D),
                  ),
                  child: Text(
                    "Dystopian",
                    style: TextStyle(color: Color(0xFFD1AE8D)),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5C260D),
                  ),
                  child: Text(
                    "Classic"
                    ,
                    style: TextStyle(color: Color(0xFFD1AE8D)),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5C260D),
                  ),
                  child: Text(
                    "Fantasy",
                    style: TextStyle(color: Color(0xFFD1AE8D)),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    
                    backgroundColor: Color(0xFF5C260D),
                  ),
                  child: Text(
                    "Historical",
                    style: TextStyle(color: Color(0xFFD1AE8D)),
                  ),
                ),
              ],
              ),
          ),
          Column(
            children:[
             BookListView(),
            ] 
          )
        ],
        
      ),
      
      
    );
  }
}