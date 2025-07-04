import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/pages/PdfViewerPage.dart';
import '../modules/Book.dart'; // تأكد من استيراد نموذج Book

class DetailsPage extends StatefulWidget {
  final Book book; // إضافة متغير لاستقبال بيانات الكتاب
  
  const DetailsPage({super.key, required this.book}); // تعديل الكونستركتور

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {

      final String pdfUrl = widget.book.pdfUrl;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:Color(0xFFD1AE8D) ),
         backgroundColor: Color(0xFF5C260D),
         title: Text("Book  Details"), titleTextStyle: GoogleFonts.dynaPuff(color:Color(0xFFD1AE8D), fontSize: 20 ),

),
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
 if (pdfUrl.isNotEmpty) 
              Container(
  //                decoration: BoxDecoration(
  //   gradient: LinearGradient(
  //     colors: [Color(0xFF5C260D), Color(0xFFD1AE8D)], // من لون إلى لون
  //     begin: Alignment.topLeft,
  //     end: Alignment.bottomRight,
  //   ),
  //   borderRadius: BorderRadius.circular(10),
  // ),
                child: Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(207, 95, 44, 20), 
                      padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
                      textStyle: GoogleFonts.dynaPuff(fontSize: 15,),
                    ),
                    
                    icon: Icon(Icons.import_contacts, color: Color.fromARGB(255, 255, 213, 173), size: 25,),
                    label: Text("Read Book" , style: TextStyle( color:Color.fromARGB(255, 255, 213, 173),),),
                    onPressed: () {
                      // Navigate to the PDF Viewer page, passing the correct URL
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewerPage(pdfUrl: pdfUrl),
                        ),
                      );
                    },
                  ),
                ),
              ),

            Center(
              child: Text(
                widget.book.name, // استخدام عنوان الكتاب من البيانات
                style: GoogleFonts.dynaPuff(
                  color: const Color.fromARGB(255, 95, 61, 49),
                  fontSize: 30,
                  
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
                    text: "Author :   ",
                    style: GoogleFonts.dynaPuff(
                      color: const Color.fromARGB(255, 71, 47, 38),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      
                    ),
                  ),
                  TextSpan(
                    text: widget.book.author, // استخدام اسم المؤلف من البيانات
                    style: GoogleFonts.dynaPuff(color: Colors.brown),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Category :   ",
                    style: GoogleFonts.dynaPuff(
                      color: const Color.fromARGB(255, 71, 47, 38),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: widget.book.category, // استخدام التصنيف من البيانات
                    style: GoogleFonts.dynaPuff(color: Colors.brown),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Added On :   ",
                    style: GoogleFonts.dynaPuff(
                      color: const Color.fromARGB(255, 71, 47, 38),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: widget.book.date.toString(), // استخدام التاريخ من البيانات
                    style: GoogleFonts.dynaPuff(color: Colors.brown),
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
                        style: GoogleFonts.dynaPuff(
                          color: const Color.fromARGB(255, 71, 47, 38),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      widget.book.about, // استخدام الوصف من البيانات
                      style: GoogleFonts.dynaPuff(color: Colors.white , fontSize: 16, textStyle: TextStyle( wordSpacing: 2.5)),
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