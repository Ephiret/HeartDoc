import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/screens/doctor.dart';
import 'package:HeartDoc/scr/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const DISEASE = "disease";
  static const DOB = "dob";
  static const DOCTOR = "doctor";
  // static const STRIPE_ID = "stripeId";
  // static const CART = "cart";

  String _name;
  String _email;
  String _id;
  String _disease;
  String _dob;
  String _doctor;
  // String _stripeId;
  // int _priceSum = 0;
  // int _quantitySum = 0;

//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get disease => _disease;
  String get dob => _dob;
  String get doctor => _doctor;
  // String get stripeId => _stripeId;

//  public variable

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _disease = snapshot.data[DISEASE];
    _dob = snapshot.data[DOB];
    _doctor = snapshot.data[DOCTOR];
  }
}

class DocModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PASS = "password";
  // static const STRIPE_ID = "stripeId";
  // static const CART = "cart";

  String _name;
  String _email;
  String _id;
  String _password;
  // int _priceSum = 0;
  // int _quantitySum = 0;

//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get password => _password;

//  public variable

  DocModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _password = snapshot.data[PASS];
  }
}

List<doctor> docs = [
  doctor(name: "Dr Ayush", email: "ayush1234@gmail.com", pass: "123456"),
  doctor(name: "Dr Rakesh", email: "rakesh1234@gmail.com", pass: "123456"),
  doctor(name: "Dr Rahul", email: "rahul1234@gmail.com", pass: "123456"),
  doctor(name: "Dr Fahiem", email: "fahiem1234@gmail.com", pass: "123456"),
  doctor(name: "Dr Harshit", email: "harshit1234@gmail.com", pass: "123456"),
];

class doctor {
  final String name;
  final String email;
  final String pass;
  doctor({this.email, this.pass, this.name});
}

Future<bool> verifyDoc(
    String email, String password, BuildContext context) async {
  print(email);
  print(email);
  print(email);
  print(email);
  for (int i = 0; i < docs.length; i++) {
    if (docs[i].email == email && docs[i].pass == password) {
      print("true");
      changeScreenReplacement(context, Doctor(docs, i));
    }
  }
  return false;
}


