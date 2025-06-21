import 'package:flutter/material.dart';

class Personalpage extends StatefulWidget {
  const Personalpage({super.key});

  @override
  State<Personalpage> createState() => _PersonalpageState();
}

class _PersonalpageState extends State<Personalpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE3BF),
      body: ListView(
        children: [
          Container(
            height: 130,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Color(0xF2541C03),
            ),

            child: Row(
              children: [
                SizedBox(width: 20),
                CircleAvatar(radius: 30),
                SizedBox(width: 30),
                Text(
                  "Kenana Jarroud\nkenana@gmail.com",
                  style: TextStyle(
                    color: Color(0xFFD1AE8D),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xF2541C03),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),

                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.book_outlined, color: Color(0xFFD1AE8D)),
                      Text(
                        " 100 books read",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFD1AE8D),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xF2541C03),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),

                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.favorite_border, color: Color(0xFFD1AE8D)),
                      Text(
                        " 23 books loved",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFD1AE8D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 200,),
      
      
          
        ],
      ),
    );
  }
}