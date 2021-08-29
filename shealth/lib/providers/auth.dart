import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
class User{
  final email;
  final isDoctor;
  User({this.email,this.isDoctor});
}
class Auth extends ChangeNotifier {
  String? _token ;
  bool get isAuth {
    return _token != null;
  }

  String get token{
    return _token!;
  }
  User user = User() ;
  Future<void> registerDoctor(String name, String email, String phNo,
      String speciality, String password) async {
    final url = Uri.parse('https://shealthapi.servatom.com/register/d/');
    try {
      final response = await http.post(url, body: {
        "name": name,
        "email": email,
        "phone": phNo,
        "speciality": speciality,
        "password": password,
      });
      if (response.statusCode != 200) {
        var responseData = jsonDecode(response.body) as Map<String, dynamic>;
        var error = responseData["errors"] as Map<String, dynamic>;
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> registerPatient(String name, String email, String phNo,
      String gender, String age, String password) async {
    final url = Uri.parse('https://shealthapi.servatom.com/register/p/');
    try {
      final response = await http.post(url, body: {
        "name": name,
        "email": email,
        "phone": phNo,
        "age": age,
        "password": password,
        "sex":gender,
      });
      if (response.statusCode != 200) {
        var responseData = jsonDecode(response.body) as Map<String, dynamic>;
        var error = responseData["errors"] as Map<String, dynamic>;
      }else{
        print('nahi hua');
      }
    } catch (e) {
      print(e);
    }
   
  }

  Future<void> signIn(String email, String password,String type) async {
    final url = Uri.parse('https://shealthapi.servatom.com/auth/login/');
    try {
      final response = await http.post(url, body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        _token = jsonDecode(response.body)["key"];
        
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userData', _token!);
        
        if(type=='Patient'){
          user = User(email: email,isDoctor: false);
          prefs.setString('email', user.email);
          prefs.setBool('isDoctor', false);
        }
        else{
          user = User(email: email,isDoctor: true);
          prefs.setString('email', user.email);
          prefs.setBool('isDoctor', true);
        }
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
     
  }
  void logout() async {
    _token = null;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    _token = prefs.getString('userData');
    user = User(email: prefs.getString('email'),isDoctor: prefs.getBool('isDoctor'));
    notifyListeners();
    
    return true;
  }
  
 


}