import 'package:evently_c17_fri/core/firebase_functions.dart';
import 'package:evently_c17_fri/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? firebaseUser;
  UserModel? userModel;

  AuthProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    userModel = await FirebaseFunctions.readUser();
    notifyListeners();
  }
}
