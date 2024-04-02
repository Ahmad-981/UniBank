import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:unibank/models/money_transfer.dart';

class NotificationController extends GetxController {
  final CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection("managenotifications");

  final RxList<MoneyTransfer> _transactions = <MoneyTransfer>[].obs;
  List<MoneyTransfer> get transactions => _transactions;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  void fetchTransactions() async {
    try {
      _isLoading.value = true; // Set loading state to true

      final querySnapshot = await _transactionCollection
          .doc(auth.currentUser!.uid)
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .get();
      final List<MoneyTransfer> transactionsList = querySnapshot.docs
          .map((doc) => MoneyTransfer.fromMap(doc.data()))
          .toList();
      _transactions.assignAll(transactionsList);
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      _isLoading.value = false; // Set loading state to false
    }
  }
}
