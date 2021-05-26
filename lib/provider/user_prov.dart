import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_plant/models/user_models.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final userProvider = ChangeNotifierProvider<UserProvider>((ref) {
  return UserProvider(ref.watch(firebaseAuthProvider));
});

class UserProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool showPassword = true;
  UserModel _userModel;
  FirebaseAuth _auth;

  UserProvider(this._auth);

//  getter
  UserModel get userModel => _userModel;

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  Future<bool> signIn() async {
    try {
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('users').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
        });
      });
      return true;
    } catch (e) {
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  void changePasswordVisible() {
    showPassword = !showPassword;
    notifyListeners();
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential).then((value) async {
        _firestore.collection('users').doc(value.user.uid).set({
          'name': value.user.displayName,
          'email': value.user.email,
          'uid': value.user.uid,
        });
      });
    } catch (e) {
      notifyListeners();
      print(e.toString());
      return false;
    }
  }
}
