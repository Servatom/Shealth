import 'dart:convert';
import 'dart:io';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class Prescription extends ChangeNotifier{
List<String> documents = []; 
final url2 = Uri.parse('https://shealthapi.servatom.com/patient/upload/');
Future getPdfAndUpload(String _token)async{
  print(_token);
  final params = OpenFileDialogParams(
    dialogType: OpenFileDialogType.document,
    sourceType: SourceType.photoLibrary,
  );
  final filePath = await FlutterFileDialog.pickFile(params: params);
  final path = Uri.parse(filePath!);
  File file = File.fromUri(path);
  final filename = file.path.split('/').last;
  final bytes = await file.readAsBytes();
  await http.post(url2,
  headers: {
  'Authorization': 'Token $_token',
  'Content-Disposition': 'multipart/form-data; filename=$filename',
  'Content-Type': 'application/pdf'
  },
  body: bytes
  );
}

Future<void> getDocuments (String token , String email) async{
  final url = Uri.parse('https://shealthapi.servatom.com/patient/records/');
  final response =await http.post(
    url,
    headers: {'Authorization': 'Token $token'},
    body: {
      "email" : email
    }
    
  );
  Iterable responseData = jsonDecode(response.body);
  documents = responseData.map((e) => e["file"].toString()).toList();
  
}
}