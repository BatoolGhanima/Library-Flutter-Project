import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/item.dart';
import '../pages/DetailsPage.dart';

class BookListView extends StatefulWidget {
  const BookListView({super.key});

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  final CollectionReference booksRef = FirebaseFirestore.instance.collection('books');
  List<Book> favoriteBook = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: booksRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        if (snapshot.hasError)
          return Center(child: Text("Error: ${snapshot.error}"));

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
          return Center(child: Text("No books found"));

        final books = snapshot.data!.docs.map((doc) {
          return Book.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        return ListView.builder(
          itemCount: books.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // حتى لا يحصل تصادم Scroll
          itemBuilder: (context, index) {
            final book = books[index];
            return Card(
              color: const Color.fromARGB(189, 233, 192, 162),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              margin: EdgeInsets.all(20),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(book.image, width: 75, height: 75, fit: BoxFit.cover),
                ),
                title: Text(
                  book.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 125, 39, 0),
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  book.author,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                   setState(() {
                     favoriteBook.add(book);
                   });
                  },
                  icon: Icon(Icons.favorite_border_outlined, color:Color.fromARGB(255, 125, 39, 0) , size: 40,),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage(book: book)),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
