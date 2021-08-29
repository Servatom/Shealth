import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Patient {
  Patient({
    this.name,
    this.email,
    this.phone,
  });

  final name;
  final email;
  final phone;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );
}

class Patients extends ChangeNotifier {
  List<Patient> _patients = [];
  List<Patient> get patient {
    return [..._patients];
  }

  final url = Uri.parse('https://shealthapi.servatom.com/doctor/plist/');
  Future<void> getPatients(String token) async {
    final response =
        await http.get(url, headers: {'Authorization': 'Token $token'});
    Iterable responseData = jsonDecode(response.body);
    final extractedData =
        responseData.map((json) => Patient.fromJson(json)).toList();
    _patients = extractedData;
  }
}
