import 'package:chat/pages/auth/login.dart';
import 'package:chat/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initializePreferences();
  }

  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxString emailValidation = RxString('');
  RxString passwordValidation = RxString('');
  RxString fullnameValidation = RxString('');
  var message = ''.obs;
  late SharedPreferences pref;
  final FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isUserLogin = false.obs;

  Future<void> initializePreferences() async {
    pref = await SharedPreferences.getInstance();
    if (pref.getString("email") != null) {
      isUserLogin.value = true;
    } else {
      isUserLogin.value = false;
    }
  }

  Future<void> signInWithEmailandPassword() async {
    if (validateLoginInputs()) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email
        });
        await pref.setString("email", userCredential.user!.email.toString());
        email.clear();
        password.clear();
        return Get.off(Home());
      } on FirebaseAuthException catch (e) {
        message.value = e.code.toString();
      }
    }
  }

  Future<void> signUpWithEmailandPassword() async {
    if (validateRegisterInputs()) {
      try {
        await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        fullname.clear();
        email.clear();
        password.clear();
        message.value="";
        return Get.off(Login());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          message.value = "Email is already in use";
        } else if (e.code == 'user-not-found') {
          message.value = "User not found";
        } else if (e.code == 'wrong-password') {
          message.value = "Wrong Credential";
        } else {
          message.value = e.code;
        }
      }
    }
  }

  Future<void> signOut() async {
    await pref.remove("email");
    await auth.signOut();
    return Get.off(Login());
  }

  bool validateRegisterInputs() {
    if (fullname.text.isEmpty) {
      fullnameValidation.value = "Fullname is required";
    } else {
      fullnameValidation.value = "";
    }
    if (email.text.isEmpty) {
      emailValidation.value = "Email is required";
    } else if (!email.text.isEmail) {
      emailValidation.value = "Incorrect email format";
    } else {
      emailValidation.value = "";
    }
    if (password.text.isEmpty) {
      passwordValidation.value = "Password is required";
    } else if (password.text.length < 8) {
      passwordValidation.value = "Password must be at least 8 characters";
    } else {
      passwordValidation.value = "";
    }
    return fullnameValidation.isEmpty &&
        passwordValidation.isEmpty &&
        emailValidation.isEmpty;
  }

  bool validateLoginInputs() {
    if (email.text.isEmpty) {
      emailValidation.value = "Email is required";
    } else if (!email.text.isEmail) {
      emailValidation.value = "Incorrect email format";
    } else {
      emailValidation.value = "";
    }
    if (password.text.isEmpty) {
      passwordValidation.value = "Password is required";
    } else if (password.text.length < 8) {
      passwordValidation.value = "Password must be at least 8 characters";
    } else {
      passwordValidation.value = "";
    }
    return passwordValidation.isEmpty && emailValidation.isEmpty;
  }
}
