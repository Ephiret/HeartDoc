import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const DISEASE = "disease";
  static const DOB = "dob";
  // static const STRIPE_ID = "stripeId";
  // static const CART = "cart";

  String _name;
  String _email;
  String _id;
  String _disease;
  String _dob;
  // String _stripeId;
  // int _priceSum = 0;
  // int _quantitySum = 0;

//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get disease => _disease;
  String get dob => _dob;
  // String get stripeId => _stripeId;

//  public variable

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _disease = snapshot.data[DISEASE];
    _dob = snapshot.data[DOB];
    _disease = snapshot.data[ID];
  }
}
