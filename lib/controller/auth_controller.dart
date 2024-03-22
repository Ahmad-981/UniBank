import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/views/auth_screen/login_screen.dart';
import 'package:unibank/widgets_common/dialoge_box.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final confirmPasswordController = TextEditingController();
  var loading = false.obs;

  //SIGN IN
  Future<UserCredential?> signIn({context}) async {
    UserCredential? userCredential;

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (userCredential.user != null) {}
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//SignUp
  Future<UserCredential?> signUp(
      {email, password, context, required phonenumber}) async {
    UserCredential? userCredential;

    try {
      //FirebaseAuth auth = FirebaseAuth.instance;
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('phoneNumber', phonenumber);
      }
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    return userCredential;
  }

  //Forget Password
  forgetPassword({context, email}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: email);
      VxToast.show(context, msg: 'Password reset email sent successfully.');
    } catch (e) {
      if (e is SocketException) {
        // Handle internet connectivity issues here
        Get.dialog(const DelayedDisplay(
          delay: Duration(microseconds: 100),
          child: CustomDialog(
            success: false,
            message: "It's not Us. It's Your Internet!",
          ),
        ));
      } else {
        // Handle other exceptions here
        Get.dialog(const DelayedDisplay(
          delay: Duration(microseconds: 100),
          child: CustomDialog(
            success: false,
            message: "Tings Just Got Out of Control!",
          ),
        ));
      }
    }
  }

  storageUserData({
    email,
    name,
    phone,
    address,
    password,
  }) async {
    DocumentReference docRef =
        fireStore.collection(userCollection).doc(currentUser!.uid);
    await docRef.set({
      'id': currentUser!.uid,
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'address': address,
    });
  }

  //Logout
  logout(context) async {
    try {
      await auth.signOut().then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('phoneNumber');
        // if (value != null) {
        VxToast.show(context,
            msg: "Successfully Logout",
            showTime: 5000,
            bgColor: fontGrey,
            textColor: whiteColor);
        Get.offAll(() => const LoginScreen());
        // }
      });
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  Future<String> fetchPhoneNumberFromFirestore(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection) // Change this to your collection name
          .doc(userId)
          .get();
      if (doc.exists) {
        // Explicitly cast to Map<String, dynamic>
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Access the 'phone' field from the map
        return data['phone'] ?? '';
      }
    } catch (e) {
      print('Error fetching phone number from Firestore: $e');
    }
    return '';
  }
}
