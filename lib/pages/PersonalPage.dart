import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Personalpage extends StatefulWidget {
  const Personalpage({super.key});

  @override
  State<Personalpage> createState() => _PersonalpageState();
}

class _PersonalpageState extends State<Personalpage> {
  String userName = 'Guest';
  String userEmail = '';
  
  int quotesCount = 0;
  List<Map<String, dynamic>> userQuotes = [];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userEmail = user?.email ?? '';
    userName = user?.displayName ?? 'Guest';
    fetchUserStats();
  }

  Future<void> fetchUserStats() async {
    try {
      final booksSnapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('email', isEqualTo: userEmail)
          .get();

      final quotesSnapshot = await FirebaseFirestore.instance
          .collection('quotes')
          .where('email', isEqualTo: userEmail)
          .get();

      setState(() {
        
        quotesCount = quotesSnapshot.docs.length;
        userQuotes = quotesSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print('Error fetching stats: $e');
    }
  }

  Future<void> showAddQuoteDialog() async {
    final bookController = TextEditingController();
    final readerController = TextEditingController();
    final quoteController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentTextStyle:
            TextStyle(fontSize: 12, color: Color.fromARGB(199, 125, 40, 0)),
        backgroundColor: Color.fromARGB(255, 209, 174, 141),
        elevation: 5,
        title: Text("Add New Quote"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: bookController,
                decoration: InputDecoration(labelText: "Book Name"),
              ),
              TextField(
                controller: readerController,
                decoration: InputDecoration(labelText: "Reader Name"),
              ),
              TextField(
                controller: quoteController,
                decoration: InputDecoration(labelText: "Quote"),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel",
                style: TextStyle(color: Color.fromARGB(199, 125, 40, 0))),
          ),
          ElevatedButton(
            onPressed: () async {
              if (bookController.text.isNotEmpty &&
                  readerController.text.isNotEmpty &&
                  quoteController.text.isNotEmpty) {
                await FirebaseFirestore.instance.collection('quotes').add({
                  'bookName': bookController.text.trim(),
                  'readerName': readerController.text.trim(),
                  'quoteText': quoteController.text.trim(),
                  'email': userEmail,
                  'timestamp': FieldValue.serverTimestamp(),
                });
                Navigator.pop(context);
                fetchUserStats();
              }
            },
            child: Text("Save",
                style: TextStyle(color: Color.fromARGB(199, 125, 40, 0))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3BF),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF5C260D),
        onPressed: showAddQuoteDialog,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          // الخلفية الثابتة
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bookBackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // تأثير الضبابية
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0)),
          ),

          ListView(
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
                      child:
                          Icon(Icons.person, size: 40, color: Color(0xFFD1AE8D)),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.book_outlined, color: Color(0xFFD1AE8D)),
                        SizedBox(width: 5),
                        Text("20 books",
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFFD1AE8D))),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.format_quote, color: Color(0xFFD1AE8D)),
                        SizedBox(width: 5),
                        Text("$quotesCount quotes",
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFFD1AE8D))),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Your Quotes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5C260D),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ...userQuotes.map((quote) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(220, 209, 174, 141),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" Book: ${quote['bookName']}",
                          style:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      Text("Reader: ${quote['readerName']}"),
                      const SizedBox(height: 8),
                      Text("\"${quote['quoteText']}\"",
                          style:
                              const TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                );
              }).toList(),

              const SizedBox(height: 60),
            ],
          ),
        ],
      ),
    );
  }
}
