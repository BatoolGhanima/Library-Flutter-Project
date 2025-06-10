import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_app/pages/DetailsPage.dart';
import '../modules/item.dart'; // تأكد أن ملف Book موجود ومُعرف صح

class BookListPage extends StatelessWidget {
  final CollectionReference booksRef = FirebaseFirestore.instance.collection('books');

  final TextEditingController name = TextEditingController();




  // دالة إضافة كتاب
  // void addBook() async {
  //   if (name.text.isEmpty) return;

  //   Book newBook = Book(
  //     name: name.text,
  //     author: "Author Name",
  //     category: "Category",
  //     image: "https://via.placeholder.com/150",
  //     link: "https://example.com",
  //     about: "Description",
  //     count: 1,
  //     date: DateTime.now().year,
  //   );

  //   try {
  //     await booksRef.add(newBook.toMap());
  //     name.clear();
  //   } catch (e) {
  //     print("Error adding book: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Books")),
      backgroundColor: const Color(0xFFFFE8CA),
      body: StreamBuilder<QuerySnapshot>(
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
            itemBuilder: (context, index) {
              final book = books[index];


              return
    
            
                 Card(
                  
                  color: const Color(0xFFAF8260),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(20),
                  child: ListTile(
                   
                    contentPadding: EdgeInsets.all(16),
                    leading: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Image.network(book.image, width: 75, height: 75, fit: BoxFit.cover,)),
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
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: (){
                       Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => DetailsPage(book: book) 
      )
    );
                    },
                    
                  ),
                );
              

            },
          );
        },
      ),
    
    );
  }
}
