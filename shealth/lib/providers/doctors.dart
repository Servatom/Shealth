import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Doctor {
    Doctor({
        this.name,
        this.email,
        this.phone,
        
    });

    final name;
    final email;
    final phone;
    

    factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        
    );    
}

class Doctors extends ChangeNotifier{
  List<Doctor> _doctors = [];
  List<Doctor> get doctor {
    return [..._doctors];
  }
  final url = Uri.parse('https://shealthapi.servatom.com/patient/dlist/');
  Future<void> getDoctors(String token)async{
    final response = await http.get(url,headers: {'Authorization': 'Token $token'});
    Iterable responseData = jsonDecode(response.body);
    final extractedData =
            responseData.map((json) => Doctor.fromJson(json)).toList();
    _doctors = extractedData;
  }
  Future<void> addDoctor(String token , String docId)async{
    final url = Uri.parse('https://shealthapi.servatom.com/patient/access/doc_id/');
    await http.post(
      url,
      headers: { 'Authorization': 'Token $token'},
      body: {"doc_id": docId}
    );
  }
}