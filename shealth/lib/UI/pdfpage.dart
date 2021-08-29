import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfView extends StatelessWidget {
  PdfView({this.url});
  final url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Pdf'),
          backgroundColor: Color(0xffb793da),
        ),
        body: Container(
          child: PDF().cachedFromUrl('$url'),
        ));
  }
}
