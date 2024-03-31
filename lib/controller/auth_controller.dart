import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/views/auth_screen/login_screen.dart';
import 'package:unibank/views/home_screen/home.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final confirmPasswordController = TextEditingController();
  var loading = false.obs;

  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoggedInStatus(); // Check if the user is logged in when the controller is initialized
  }

  Future<void> checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setLoggedInStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
    isLoggedIn.value = status;
  }

  //SIGN IN
  Future<UserCredential?> signIn({context}) async {
    UserCredential? userCredential;

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await setLoggedInStatus(true);
      await userCredential.user!.reload();
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//SignUp
  // Future<UserCredential?> signUp({email, password, context}) async {
  //   UserCredential? userCredential;

  //   try {
  //     //FirebaseAuth auth = FirebaseAuth.instance;
  //     userCredential = await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     VxToast.show(context, msg: e.toString());
  //   }
  //   return userCredential;
  // }

  Future<UserCredential?> signUp({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Send email verification
      await userCredential.user!.sendEmailVerification();
      VxToast.show(context,
          msg: 'Verification email sent to $email. Please check your inbox.',
          showTime: 5000,
          bgColor: fontGrey,
          textColor: whiteColor);

      // Wait for email verification
      await userCredential.user!.reload();
      await setLoggedInStatus(true);
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
      VxToast.show(context,
          msg: 'Password reset email sent successfully.',
          showTime: 5000,
          bgColor: fontGrey,
          textColor: whiteColor);
    } catch (e) {
      VxToast.show(context,
          msg: 'Error: $e',
          showTime: 5000,
          bgColor: fontGrey,
          textColor: whiteColor);
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
      // 'amount': '100'
    });
  }

  //Logout
  logout(context) async {
    try {
      await auth.signOut().then((value) async {
        await setLoggedInStatus(false);
        // if (value != null) {
        // VxToast.show(context,
        //     msg: "Successfully Logout",
        //     showTime: 5000,
        //     bgColor: fontGrey,
        //     textColor: whiteColor);
        Get.offAll(() => const LoginScreen());
        // }
      });
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
