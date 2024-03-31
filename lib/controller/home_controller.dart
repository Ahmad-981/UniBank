import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:unibank/views/auth_screen/login_screen.dart';

import '../models/user_model.dart';

class HomeController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null); // Make currentUser observable
  RxString? amount = RxString('0');
  @override
  void onInit() {
    fetchUserDataFromFirestore();
    fetchAmountFromFirestore();
    super.onInit();
  }

  final homeController = TextEditingController();
  var currenItemIndex = 0.obs;
  var username = '';
  var loading = false.obs;

  fetchUserDataFromFirestore() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        currentUser.value = User.fromMap(data); // Assign value to currentUser
        try {
          DocumentSnapshot doc = await FirebaseFirestore.instance
              .collection('transactions') // Replace with your collection name
              .doc(currentUser.value!.phone)
              .get();

          if (doc.exists) {
            amount!.value =
                doc['amount']; // Assign amount to the observable variable
          }
        } catch (e) {
          print('Error fetching amount from Firestore: $e');
        }
      }
    } catch (e) {
      print('Error fetching user data from Firestore: $e');
    }
  }

  logout(context) async {
    try {
      await auth.signOut().then((value) {
        Get.offAll(() => const LoginScreen());
        // }
      });
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  fetchAmountFromFirestore() async {}
}
