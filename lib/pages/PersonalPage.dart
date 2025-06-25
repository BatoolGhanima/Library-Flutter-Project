import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Personalpage extends StatefulWidget {
  const Personalpage({super.key});

  @override
  State<Personalpage> createState() => _PersonalpageState();
}

class _PersonalpageState extends State<Personalpage> {
  String userName = 'Guest';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email ?? '';
      userName = user?.displayName ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3BF),
      body: ListView(
        children: [
          Container(
            height: 130,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Color(0xF2541C03),
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFF5C260D),
                  child: Icon(Icons.person, size: 40, color: Color(0xFFD1AE8D)),
                ),
                const SizedBox(width: 30),
                Text(
                  "$userName\n$userEmail",
                  style: const TextStyle(
                    color: Color(0xFFD1AE8D),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 150,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xF2541C03),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    children: const [
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
                  margin: const EdgeInsets.all(10),
                  width: 150,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xF2541C03),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    children: const [
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
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}
