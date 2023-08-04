import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfView extends StatefulWidget {
  final String fileUrl;
  const PdfView({super.key, required this.fileUrl});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  PDFDocument? document;
  void initialisePdf() async{
    document = await PDFDocument.fromURL(widget.fileUrl);
    setState(() {});
  }
  void initState(){
    super.initState();
    initialisePdf();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: document!=null?PDFViewer(document: document!):Center(child: CircularProgressIndicator(),),
    );
  }
}
