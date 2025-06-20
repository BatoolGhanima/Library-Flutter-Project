import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_app/components/BookListView.dart';
import 'package:library_app/pages/DetailsPage.dart';
import '../modules/item.dart'; // تأكد أن ملف Book موجود ومُعرف صح

class BookListPage extends StatelessWidget {
  final CollectionReference booksRef = FirebaseFirestore.instance.collection('books');

  final TextEditingController name = TextEditingController();
  final TextEditingController author = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController about = TextEditingController();
  final TextEditingController count = TextEditingController();
  final TextEditingController image = TextEditingController();
  final TextEditingController pdfUrl = TextEditingController();

  // دالة إضافة كتاب
  void addBook() async {
    if (name.text.isEmpty) return;

    Book newBook = Book(
      name: name.text,
      author: author.text,
      category: category.text,
      image: image.text,
      about: about.text,
      count: int.tryParse(count.text) ?? 1,
      date: int.tryParse(date.text) ?? DateTime.now().year,
      pdfUrl: pdfUrl.text,
    );

    try {
      await booksRef.add(newBook.toMap());
      name.clear();
      author.clear();
      about.clear();
      image.clear();
      category.clear();
      count.clear();
      pdfUrl.clear();
      date.clear();
    } catch (e) {
      print("Error adding book: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // صورة الخلفية
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

          // محتوى الصفحة فوق الخلفية
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                     
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                        
                           contentTextStyle: TextStyle(fontSize: 12 , color: Color.fromARGB(199, 125, 40, 0)),

                          backgroundColor: Color.fromARGB(255, 209, 174, 141),
                          elevation: 5,
                          title: Text(
                            "Add Book",
                            style: TextStyle(color: Color.fromARGB(255, 125, 39, 0)),
                          ),
                          content: SingleChildScrollView(
                            
                            child: Column(
                            
                              children: [
                                TextField(controller: name, decoration: InputDecoration(labelText: "Book Name")),
                                TextField(controller: author, decoration: InputDecoration(labelText: "Author Name")),
                                TextField(controller: category, decoration: InputDecoration(labelText: "Category Name")),
                                TextField(controller: about, decoration: InputDecoration(labelText: "About...")),
                                TextField(controller: count, decoration: InputDecoration(labelText: "Books Count")),
                                TextField(controller: date, decoration: InputDecoration(labelText: "Publish Year")),
                                TextField(controller: image, decoration: InputDecoration(labelText: "Image Link")),
                                TextField(controller: pdfUrl, decoration: InputDecoration(labelText: "PDF URL")),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                addBook();
                                Navigator.pop(context);
                              },
                              child: Text("Add" ,style: TextStyle(color: Color.fromARGB(221, 92, 38, 13), fontSize: 16 ),),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(221, 92, 38, 13),
                    foregroundColor: Color(0xFFD1AE8D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add new book   ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.add_card, size: 20),
                    ],
                  ),
                ),
              ),
              BookListView(),
            ],
          ),
        ],
      ),
    );
  }
}
