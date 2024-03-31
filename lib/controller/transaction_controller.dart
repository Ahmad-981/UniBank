import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:unibank/models/money_transfer.dart';

class TransactionController extends GetxController {
  final CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection(manageTransaction);
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection(userCollection);

  final RxList<MoneyTransfer> _transactions = <MoneyTransfer>[].obs;
  List<MoneyTransfer> get transactions => _transactions;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxDouble _totalSent = 0.0.obs;
  double get totalSent => _totalSent.value;

  final RxDouble _totalReceived = 0.0.obs;
  double get totalReceived => _totalReceived.value;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  void fetchTransactions() async {
    try {
      _isLoading.value = true; // Set loading state to true

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();

      String currentPhone = doc['phone'];

      final querySnapshot = await _transactionCollection
          .doc(currentPhone)
          .collection('transactions')
          .get();
      final List<MoneyTransfer> transactionsList = querySnapshot.docs
          .map((doc) =>
              MoneyTransfer.fromMap(doc.data()))
          .toList();
      _transactions.assignAll(transactionsList);

      // Calculate total sent and received amounts
      double sentAmount = 0.0;
      double receivedAmount = 0.0;
      for (var transaction in transactionsList) {
        if (transaction.received) {
          receivedAmount += double.parse(transaction.amount);
        } else {
          sentAmount += double.parse(transaction.amount);
        }
      }
      _totalSent.value = sentAmount;
      _totalReceived.value = receivedAmount;
    } catch (e) {
      // Handle errors
      print(e.toString());
    } finally {
      _isLoading.value = false; // Set loading state to false
    }
  }
}
