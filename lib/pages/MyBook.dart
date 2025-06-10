// import 'package:flutter/material.dart';

// class MyBook extends StatefulWidget {
//   const MyBook({super.key});

//   @override
//   State<MyBook> createState() => _MyBookState();
// }

// class _MyBookState extends State<MyBook> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: Text("books"),),
//     backgroundColor: const Color(0xFFFFE8CA),
//     body:
//     ListView(
      
//       children: [
//         Card(
          
//           color: const Color(0xFFAF8260),
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(15),
//   ),
//   elevation: 3,
//   margin: EdgeInsets.all(20),
//   child: Padding(
//     padding: EdgeInsets.all(16),
//     child: Row(
//       children: [
//         Icon(Icons.book, size: 40),
//         SizedBox(width: 16),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Book Title", style: TextStyle(fontWeight: FontWeight.bold , color: const Color.fromARGB(255, 125, 39, 0), fontSize: 20)),
//             Text("Author Name"),
//           ],
//         ),
//       ],
//     ),
//   ),
// )

//       ],
//     )
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../modules/item.dart'; // تأكد من أنك وضعت كلاس Book في ملف منفصل أو في نفس الملف

// class BookListPage extends StatelessWidget {
//   final CollectionReference booksRef =
//       FirebaseFirestore.instance.collection('books');
// GlobalKey<FormState> formState = GlobalKey<FormState>();
// TextEditingController name = TextEditingController();
// void addBook() async {
//   if (name.text.isEmpty) return;

//   Book newBook = Book(
//     name: name.text,
//     author: "Author Name",     // لاحقًا استخدم TextEditingController مخصص له
//     category: "Category",      // نفس الشيء
//     image: "https://via.placeholder.com/150", // رابط صورة مؤقت
//     link: "https://example.com", // رابط تحميل
//     about: "Description",
//     count: 1,
//     date: DateTime.now().year,
//   );

//   try {
//     await booksRef.add(newBook.toMap());
//     name.clear();
//     // أضف رسائل نجاح إن أردت
//   } catch (e) {
//     print("Error adding book: $e");
//   }
// }

//  @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("Books"),
//       backgroundColor: const Color.fromARGB(255, 111, 54, 0),
//     ),
//     body: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: name,
//             decoration: InputDecoration(
//               labelText: 'Book Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: addBook,
//           child: Text("Add"),
//         ),
//         Expanded(
//           child: StreamBuilder<QuerySnapshot>(
//             stream: booksRef.snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting)
//                 return Center(child: CircularProgressIndicator());

//               if (snapshot.hasError)
//                 return Center(child: Text("Error: ${snapshot.error}"));

//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
//                 return Center(child: Text("No books found"));

//               final books = snapshot.data!.docs.map((doc) {
//                 return Book.fromMap(doc.data() as Map<String, dynamic>);
//               }).toList();

//               return ListView.builder(
//                 itemCount: books.length,
//                 itemBuilder: (context, index) {
//                   final book = books[index];
//                   return ListTile(
//                     leading: Image.network(book.image, width: 50, height: 50, fit: BoxFit.cover),
//                     title: Text(book.name),
//                     subtitle: Text("By ${book.author} • ${book.category}"),
//                     trailing: Text("${book.date}"),
//                     onTap: () {
//                       // عرض التفاصيل إن أردت
//                     },
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   }

