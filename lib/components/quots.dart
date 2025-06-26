import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddQuotePage extends StatefulWidget {
  const AddQuotePage({super.key});

  @override
  State<AddQuotePage> createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController readerNameController = TextEditingController();
  final TextEditingController quoteTextController = TextEditingController();

  void addQuote() async {
    String bookName = bookNameController.text.trim();
    String readerName = readerNameController.text.trim();
    String quoteText = quoteTextController.text.trim();
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (bookName.isNotEmpty && readerName.isNotEmpty && quoteText.isNotEmpty) {
      await FirebaseFirestore.instance.collection('quotes').add({
        'bookName': bookName,
        'readerName': readerName,
        'quoteText': quoteText,
        'userEmail': userEmail,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("qoute added succefally")));

      // إفراغ الحقول بعد الإضافة
      bookNameController.clear();
      readerNameController.clear();
      quoteTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Qoute")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: bookNameController,
              decoration: InputDecoration(labelText: "Book Name"),
            ),
            TextField(
              controller: readerNameController,
              decoration: InputDecoration(labelText: " Reader Name"),
            ),
            TextField(
              controller: quoteTextController,
              maxLines: 4,
              decoration: InputDecoration(labelText: "Qoutes"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: addQuote, child: Text(" Save Qoute")),
          ],
        ),
      ),
    );
  }
}
