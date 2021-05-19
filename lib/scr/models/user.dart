import 'dart:math';
import 'package:HeartDoc/scr/providers/globals.dart' as globals;
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/screens/doctor.dart';
import 'package:HeartDoc/scr/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:HeartDoc/scr/providers/globals.dart' as globals;

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

Future<bool> verifyDoc(
  String email, String password, BuildContext context) async {
  for (int i = 0; i < globals.docs.length; i++) {
    if (globals.docs[i].email == email && globals.docs[i].pass == password) {
      print("true");
      changeScreenReplacement(context, Doctor(globals.docs, i));
    }
  }
  return false;
}

Firestore _firestore = Firestore.instance;
String date = DateTime.now().toString();
updatepatient(String email, String result) async {
  globals.contents = globals.contents + "  " + date;
  _firestore.collection('patient').document(email).updateData({
    "Date-Status": FieldValue.arrayUnion([date + "   :   " + result]),
    //"Status": FieldValue.arrayUnion([result]),
    "Contents": FieldValue.arrayUnion([globals.contents]),
  });
  globals.contents = "";
}


bool adddoctor(String email, String name, String pass) {
  print(globals.docs.length);
  globals.doctor d = new globals.doctor(name: name, email: email, pass: pass);
  for (int i = 0; i < globals.docs.length; i++) {
    if (globals.docs[i].email == email) {
      return false;
    }
  }
  globals.docs.add(d);
  print(globals.docs.length);
  return true;
}

bool removedoctor(String email) {
  print(globals.docs.length);
  for (int i = 0; i < globals.docs.length; i++) {
    if (globals.docs[i].email == email) {
      globals.docs.removeAt(i);
      return true;
    }
  }
  print(globals.docs.length);
  return false;
}
