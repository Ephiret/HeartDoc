import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:HeartDoc/scr/helpers/user.dart';
import 'package:HeartDoc/scr/models/user.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  UserServices _userServicse = UserServices();
  UserModel _userModel;
  DocModel _docModel;

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _user;
  DocModel get docModel => _docModel;

  // public variables

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController disease = TextEditingController();
  TextEditingController doctor = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> Update(String userid) async {
    _firestore.collection('users').document(userid).updateData({
      'name': name.text,
      'disease': disease.text,
      'dob': dob.text,
      'email': email.text,
      'doctor': doctor.text,
    });
    _firestore.collection('patient').document(email.text).updateData({
      'name': name.text,
      'doctor': doctor.text,
      'disease': disease.text,
      'email': email.text,
      'dob': dob.text,
    });
    return true;
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('users').document(result.user.uid).setData({
          'name': name.text,
          'disease': disease.text,
          'dob': dob.text,
          'email': email.text,
          'uid': result.user.uid,
          'doctor': doctor.text,
        });
        _firestore.collection('patient').document(email.text).setData({
          'name': name.text,
          'disease': disease.text,
          'Date-Status': "null",
          'doctor': doctor.text,
          'email': email.text,
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    dob.text = "";
    disease.text = "";
    doctor.text = "";
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServicse.getUserById(user.uid);
    notifyListeners();
  }

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServicse.getUserById(user.uid);
    }
    notifyListeners();
  }
}

