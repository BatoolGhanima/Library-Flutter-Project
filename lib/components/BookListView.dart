import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_app/modules/Book.dart';
import '../pages/DetailsPage.dart';


class BookListView extends StatelessWidget {
  final List<Book>? books; // ممكن تكون null => نعرض من Firebase

  const BookListView({super.key, this.books});

  @override
  Widget build(BuildContext context) {
    if (books != null) {
      if (books!.isEmpty) return Center(child: Text("No books found"));
      return buildListView(books!);
    }

    final CollectionReference booksRef = FirebaseFirestore.instance.collection('books');

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

        return buildListView(books);
      },
    );
  }

  Widget buildListView(List<Book> books) {
    return ListView.builder(
      itemCount: books.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
            trailing: Icon(Icons.favorite_border_outlined, color:Color.fromARGB(255, 125, 39, 0), size: 40),
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
  }
}
