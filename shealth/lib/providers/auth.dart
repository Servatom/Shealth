import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  Future<void> registerDoctor(String name, String email, String phNo,String speciality, String password) async {
    final url = Uri.parse('https://shealthapi.servatom.com/register/d/');
    try {
     final response = await http.post(url, body: {
        "name": name,
        "email": email,
        "phone": phNo,
        "speciality": speciality,
        "password": password,
      });
      if(response.statusCode !=200){
        var responseData = jsonDecode(response.body) as Map<String,dynamic>;
        var error = responseData["errors"] as Map<String,dynamic>;
      }
    } catch (e) {
      print(e);
    }
  }
}
