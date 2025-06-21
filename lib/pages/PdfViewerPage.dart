// pdf_viewer_page.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl;

  const PdfViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late Future<File> _pdfFile;

  // This function will download the PDF from the URL and return it as a File object.
  Future<File> loadPdfFromUrl() async {
    try {
      final uri = Uri.parse(widget.pdfUrl);
      final response = await http.get(uri);
      final bytes = response.bodyBytes;
      
      // Get the temporary directory on the device
      final dir = await getTemporaryDirectory();
      // Create a file with a unique name (or a consistent one if you want to cache)
      final file = File(join(dir.path, 'book.pdf'));
      
      // Write the downloaded bytes to the file
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      // If anything goes wrong, throw an error.
      throw Exception("Error loading PDF: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // Start loading the PDF when the widget is first created
    _pdfFile = loadPdfFromUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:Color(0xFFD1AE8D) ),
        backgroundColor:  Color(0xFF5C260D),
        title: Text("Reading Book"), titleTextStyle: GoogleFonts.dynaPuff(color:Color(0xFFD1AE8D), fontSize: 20 ),
      ),
      body: FutureBuilder<File>(
        future: _pdfFile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the future is complete, check for errors or show the PDF
            if (snapshot.hasError) {
              return Center(child: Text("Error loading PDF: ${snapshot.error}"));
            }
            if (snapshot.hasData) {
              // If we have data (the file), show the PDFView widget
              return PDFView(
                filePath: snapshot.data!.path,
                enableSwipe: true,
                swipeHorizontal: false, // For vertical scrolling
                autoSpacing: false,
                pageFling: true,
              );
            }
          }
          
          // While the future is loading, show a progress indicator
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}