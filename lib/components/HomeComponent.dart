import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_app/components/BookListView.dart';
import 'package:library_app/modules/Book.dart';

class Homecomponent extends StatefulWidget {
  const Homecomponent({super.key});

  @override
  State<Homecomponent> createState() => _HomecomponentState();
}

class _HomecomponentState extends State<Homecomponent> {
  TextEditingController searchController = TextEditingController();
  List<Book> searchResults = [];
  bool isSearching = false;

  List<Book> displayedBooks = []; // نتائج الفلترة
  String? selectedCategory; // النوع الحالي

  final CollectionReference booksRef = FirebaseFirestore.instance.collection(
    'books',
  );

  void searchBooksByName() async {
    String query = searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        searchResults = [];
      });
      return;
    }

    try {
      QuerySnapshot snapshot =
          await booksRef.orderBy('name').startAt([query]).endAt([
            query + '\uf8ff',
          ]).get();

      List<Book> results =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Book.fromMap(data);
          }).toList();

      setState(() {
        isSearching = true;
        searchResults = results;
      });
    } catch (e) {
      print('Error searching books: $e');
    }
  }

  void filterBooksByCategory(String category) async {
    try {
      QuerySnapshot snapshot =
          await booksRef.where('category', isEqualTo: category).get();

      List<Book> categoryBooks =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Book.fromMap(data);
          }).toList();

      setState(() {
        selectedCategory = category;
        isSearching = false; // تعطيل نتائج البحث عند الفلترة
        searchResults = [];
        displayedBooks = categoryBooks;
      });
    } catch (e) {
      print('Error filtering books by category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Container(color: Colors.black.withOpacity(0)),
          ),

          ListView(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Color(0xFF5C260D),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          isSearching = false;
                          searchResults = [];
                        });
                      },
                      icon: Icon(Icons.arrow_back, color: Color(0xFFD1AE8D)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(color: Color(0xFFD1AE8D)),
                        onChanged: (value) {
                          searchBooksByName(); // كل مرة تتغير الكلمة يتم البحث
                        },
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
                margin: EdgeInsets.only(
                  top: 10,
                  left: 25,
                  bottom: 20,
                  right: 25,
                ),

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
                      onPressed: () {
                        setState(() {
                          // إلغاء الفلترة والبحث
                          selectedCategory = null;
                          isSearching = false;
                          searchResults = [];
                          displayedBooks = [];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedCategory == "Show All"
                                ? Color(0xFFD1AE8D)
                                : Color(0xFF5C260D),
                      ),
                      child: Text(
                        "Show All",
                        style: TextStyle(color: Color(0xFFD1AE8D)),
                      ),
                    ),
                    SizedBox(width: 15),

                    ElevatedButton(
                      onPressed: () => filterBooksByCategory("Dystopian"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedCategory == "Dystopian"
                                ? Color(0xFFD1AE8D)
                                : Color(0xFF5C260D),
                      ),

                      child: Text(
                        "Dystopian",
                        selectionColor: Color.fromARGB(255, 255, 213, 0),
                        style: TextStyle(
                          color:
                              selectedCategory == "Dystopian"
                                  ? Color(0xFF5C260D)
                                  : Color(0xFFD1AE8D),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => filterBooksByCategory("Classic"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedCategory == "Classic"
                                ? Color(0xFFD1AE8D)
                                : Color(0xFF5C260D),
                      ),
                      child: Text(
                        "Classic",
                        style: TextStyle(
                          color:
                              selectedCategory == "Classic"
                                  ? Color(0xFF5C260D)
                                  : Color(0xFFD1AE8D),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => filterBooksByCategory("Fantasy"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedCategory == "Fantasy"
                                ? Color(0xFFD1AE8D)
                                : Color(0xFF5C260D),
                      ),
                      child: Text(
                        "Fantasy",
                        style: TextStyle(
                          color:
                              selectedCategory == "Fantasy"
                                  ? Color(0xFF5C260D)
                                  : Color(0xFFD1AE8D),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => filterBooksByCategory("Historical"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedCategory == "Historical"
                                ? Color(0xFFD1AE8D)
                                : Color(0xFF5C260D),
                      ),
                      child: Text(
                        "Historical",
                        style: TextStyle(
                          color:
                              selectedCategory == "Historical"
                                  ? Color(0xFF5C260D)
                                  : Color(0xFFD1AE8D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  BookListView(
                    books:
                        isSearching
                            ? searchResults
                            : selectedCategory != null
                            ? displayedBooks
                            : null,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
