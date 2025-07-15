import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// AuthService handles user authentication using Firebase Auth
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Force account selection every time
    forceCodeForRefreshToken: true,
  );

  Future<bool> loginAndNavigate(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      // Re-throw FirebaseAuthException so it can be handled by the caller
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      // Sign out from Google first to force account selection
      await _googleSignIn.signOut();

      // Trigger the authentication flow with account selection
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        return false;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      if (userCredential.user != null) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  Future<bool> registerWithGoogle(BuildContext context) async {
    try {
      // Sign out from Google first to force account selection
      await _googleSignIn.signOut();

      // Trigger the authentication flow with account selection
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        return false;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      if (userCredential.user != null) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception('Google registration failed: $e');
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  String? get currentUser => _firebaseAuth.currentUser?.email;

  User? get currentUserObject => _firebaseAuth.currentUser;
}
