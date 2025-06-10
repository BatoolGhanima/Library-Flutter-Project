import 'package:flutter/material.dart';
import '../modules/item.dart'; // تأكد من استيراد نموذج Book

class DetailsPage extends StatefulWidget {
  final Book book; // إضافة متغير لاستقبال بيانات الكتاب
  
  const DetailsPage({super.key, required this.book}); // تعديل الكونستركتور

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color.fromARGB(255, 255, 227, 191),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 97, 96, 96),
                borderRadius: BorderRadius.circular(25),
              ),
              margin: EdgeInsets.only(left: 50, right: 50),
              height: 300,
              width: 100,
              child: Image.network(
                widget.book.image, // استخدام صورة الكتاب من البيانات
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                widget.book.name, // استخدام عنوان الكتاب من البيانات
                style: TextStyle(
                  color: const Color.fromARGB(255, 95, 61, 49),
                  fontSize: 30,
                  fontFamily: "",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Author : ",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 71, 47, 38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: widget.book.author, // استخدام اسم المؤلف من البيانات
                    style: TextStyle(color: Colors.brown),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Category : ",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 71, 47, 38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: widget.book.category, // استخدام التصنيف من البيانات
                    style: TextStyle(color: Colors.brown),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Added On : ",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 71, 47, 38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: widget.book.date.toString(), // استخدام التاريخ من البيانات
                    style: TextStyle(color: Colors.brown),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Color.fromARGB(255, 175, 130, 96),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "About :",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 71, 47, 38),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      widget.book.about, // استخدام الوصف من البيانات
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // باقي العناصر...
          ],
        ),
      ),
    );
  }
}