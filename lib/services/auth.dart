import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print("Sign in page error : "+e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut().then((_) => print("Successfully signed out !!!"));
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
