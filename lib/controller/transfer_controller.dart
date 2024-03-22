import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:unibank/models/user_model.dart';
import 'package:unibank/widgets_common/dialoge_box.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');
  final isLoading = false.obs;

  Future<User?> getUserByPhone(String phoneNumber) async {
    try {
      isLoading.value = true;
      QuerySnapshot querySnapshot = await _firestore
          .collection(userCollection)
          .where('phone', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Convert the document data to a User object
        Map<String, dynamic> userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        User user = User.fromMap(userData);
        return user;
      } else {
        // No user found with the given phone number
        return null;
      }
    } catch (e) {
      Get.dialog(const DelayedDisplay(
          delay: Duration(microseconds: 100),
          child: CustomDialog(
            success: false,
            message: "Its not Us. Its Your Internet",
          )));
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadTransaction(
      String phoneNumber, String amount, String name, String purpose) async {
    try {
      isLoading.value = true;

      // Check if the user already has a wallet
      DocumentSnapshot walletDoc = await _transactions.doc(phoneNumber).get();
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();
      if (!doc.exists) {
        throw 'User document does not exist';
      }
      String currentPhone = doc['phone'];
      String sender = doc['name'];

      if (walletDoc.exists) {
        // If wallet exists, update the amount

        DocumentSnapshot doc1 = await FirebaseFirestore.instance
            .collection("transactions")
            .doc(currentPhone)
            .get();
        // Get the current date

        int currentAmount1 = int.parse(doc1['amount']) ?? 0;

        // Calculate the new total amount
        int newAmount1 = currentAmount1 - int.parse(amount);
        if (newAmount1 < 0) {
          // If the new balance is negative, show error message
          throw 'Insufficient balance';
        }
        String currentDate1 = DateTime.now().toString();

        // Add the data to Firestore
        await _transactions.doc(currentPhone).update({
          'amount': newAmount1.toString(),
          'date': currentDate1,
        });

        int currentAmount = int.parse(walletDoc['amount']) ?? 0;
        int newAmount = currentAmount + int.parse(amount);
        await _transactions.doc(phoneNumber).update({
          'amount': newAmount.toString(),
          'date': DateTime.now().toString()
        });
      } else {
        // If wallet doesn't exist, create a new one
        String currentDate = DateTime.now().toString();
        await _transactions.doc(phoneNumber).set({
          'amount': amount,
          'date': currentDate,
        });
      }

      String currentDate = DateTime.now().toString();

      await _firestore
          .collection(manageTransaction)
          .doc(phoneNumber)
          .collection("transactions")
          .add({
        'amount': amount,
        'date': currentDate,
        'name': name,
        'phone': phoneNumber,
        'purpose': purpose,
        'received': true,
        'sender': sender
      });

      await _firestore
          .collection(manageTransaction)
          .doc(currentPhone)
          .collection("transactions")
          .add({
        'amount': amount,
        'date': currentDate,
        'name': name,
        'phone': phoneNumber,
        'sender': sender,
        'purpose': purpose,
        'received': false
      });

      // Show a success dialog
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
            message: "Tings Just Got Out of Control!",
          ),
        ));
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadPayTransaction(
      String phoneNumber, String amount, String name, String purpose) async {
    try {
      isLoading.value = true;

      // Check if the user already has a wallet

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();
      if (!doc.exists) {
        throw 'User document does not exist';
      }
      String currentPhone = doc['phone'];
      String sender = doc['name'];

      DocumentSnapshot doc1 = await FirebaseFirestore.instance
          .collection("transactions")
          .doc(currentPhone)
          .get();
      // Get the current date

      int currentAmount1 = int.parse(doc1['amount']) ?? 0;

      // Calculate the new total amount
      int newAmount1 = currentAmount1 - int.parse(amount);
      if (newAmount1 < 0) {
        // If the new balance is negative, show error message
        throw 'Insufficient balance';
      }
      String currentDate1 = DateTime.now().toString();

      // Add the data to Firestore
      await _transactions.doc(currentPhone).update({
        'amount': newAmount1.toString(),
        'date': currentDate1,
      });

      String currentDate = DateTime.now().toString();

      await _firestore
          .collection(manageTransaction)
          .doc(currentPhone)
          .collection("transactions")
          .add({
        'amount': amount,
        'date': currentDate,
        'name': name,
        'sender': sender,
        'phone': phoneNumber,
        'purpose': purpose,
        'received': false
      });

      // Show a success dialog
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
        Get.dialog(DelayedDisplay(
          delay: Duration(microseconds: 100),
          child: CustomDialog(
            success: false,
            message: e.toString(),
          ),
        ));
      }
    } finally {
      isLoading.value = false;
    }
  }
}
