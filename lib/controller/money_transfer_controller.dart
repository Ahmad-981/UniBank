import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:unibank/widgets_common/dialoge_box.dart';

class MoneyTransferController extends GetxController {
  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');

  final isLoading = false.obs;

  Future<void> sendMoney(String amount) async {
    try {
      isLoading.value = true;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();
      if (!doc.exists) {
        throw 'User document does not exist';
      }
      String phoneNumber = doc['phone'];

      DocumentSnapshot doc1 = await FirebaseFirestore.instance
          .collection("transactions")
          .doc(phoneNumber)
          .get();
      // Get the current date
      if (doc1.exists) {
        int currentAmount = int.parse(doc1['amount']) ?? 0;

        // Calculate the new total amount
        int newAmount = currentAmount + int.parse(amount);
        String currentDate = DateTime.now().toString();

        // Add the data to Firestore
        await _transactions.doc(phoneNumber).set({
          'amount': newAmount.toString(),
          'date': currentDate,
        }, SetOptions(merge: true));
      } else {
        await _transactions.doc(phoneNumber).set({
          'amount': amount,
          'date': DateTime.now().toString(),
        });
      }

      // Show a snackbar when money is transferred successfully
      Get.dialog(const DelayedDisplay(
          delay: Duration(microseconds: 100),
          child: CustomDialog(success: true)));
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
            message: "Things Just Got Out of Control!",
          ),
        ));
      }
    } finally {
      isLoading.value = false;
    }
  }
}
