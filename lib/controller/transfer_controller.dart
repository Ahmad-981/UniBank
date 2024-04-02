import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:unibank/main.dart';
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

        int currentAmount1 = int.parse(doc1['amount']);

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

        int currentAmount = int.parse(walletDoc['amount']);
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

      int currentAmount1 = int.parse(doc1['amount']);

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
          delay: const Duration(microseconds: 100),
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

  Future<void> uploadInsuranceTransaction(
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

      int currentAmount1 = int.parse(doc1['amount']);

      // Calculate the new total amount
      int newAmount1 = currentAmount1 - int.parse(amount);
      if (newAmount1 < 0) {
        // If the new balance is negative, show error message
        throw 'Insufficient balance';
      }

      if (name == "Money Saver") {
        sendMoneyToLocker(amount);
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
        'purpose': "Insurace Payment",
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
          delay: const Duration(microseconds: 100),
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

  Future<void> sendMoneyToLocker(String amount) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();
      if (!doc.exists) {
        throw 'User document does not exist';
      }
      String phoneNumber = doc['phone'];

      DocumentSnapshot doc1 = await FirebaseFirestore.instance
          .collection("locker")
          .doc(phoneNumber)
          .get();
      // Get the current date
      if (doc1.exists) {
        int currentAmount = int.parse(doc1['amount']) ?? 0;

        // Calculate the new total amount
        int newAmount = currentAmount + int.parse(amount);
        String currentDate = DateTime.now().toString();

        // Add the data to Firestore
        await _locker.doc(phoneNumber).set({
          'amount': newAmount.toString(),
          'date': currentDate,
        }, SetOptions(merge: true));
      } else {
        await _locker.doc(phoneNumber).set({
          'amount': amount,
          'date': DateTime.now().toString(),
        });
      }

      // Show a snackbar when money is transferred successfully
    } catch (e) {
    } finally {}
  }

  final CollectionReference _locker =
      FirebaseFirestore.instance.collection('locker');

  Future<void> uploadSubscriptions(
      String phoneNumber, String amount, String name, String purpose) async {
    try {
      isLoading.value = true;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();
      if (!doc.exists) {
        throw 'User document does not exist';
      }
      String currentPhone = doc['phone'];
      // Check if the user already has a wallet

      // Query Firestore to check if a subscription with the same name exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(manageTransaction)
          .doc(currentPhone)
          .collection("subscriptions")
          .where('name', isEqualTo: name)
          .get();

      // Check if there are any existing subscriptions with the same name
      if (querySnapshot.docs.isNotEmpty) {
        // If a subscription with the same name already exists, print a message
        await FirebaseFirestore.instance
            .collection(manageTransaction)
            .doc(currentPhone)
            .collection("subscriptions")
            .doc(querySnapshot.docs[0]
                .id) // Assuming there's only one document with the same name
            .update({'date': DateTime.now().toString()});
        return;
      }

      String currentDate = DateTime.now().toString();

      await _firestore
          .collection(manageTransaction)
          .doc(currentPhone)
          .collection("subscriptions")
          .add({
        'amount': amount,
        'date': currentDate,
        'name': name,
        'sender': currentUser!.displayName.toString(),
        'phone': currentPhone,
        'received': false,
        'direct': true
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkAndPrintRecentSubscriptions() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();
      if (!doc.exists) {
        throw 'User document does not exist';
      }
      String currentPhone = doc['phone'];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(manageTransaction)
          .doc(currentPhone)
          .collection('subscriptions')
          .get();

      // Get the current time
      DateTime currentTime = DateTime.now();

      // Define the maximum allowed time difference (1 minute)

      // Create a list to store all the asynchronous tasks
      List<Future<void>> tasks = [];

      // Iterate through each subscription using a for loop
      for (var subscriptionDoc in querySnapshot.docs) {
        // Parse the subscription date from Firestore as a Timestamp
        String timestamp = subscriptionDoc['date'];
        DateTime subscriptionDate = DateTime.parse(timestamp);

        // Calculate the time difference between current time and subscription time
        int timeDifference = currentTime.difference(subscriptionDate).inDays;
        if (kDebugMode) {
          print("pay  $timeDifference");
        }
        // Check if the time difference is within the allowed range
        if (timeDifference.abs() >= 31) {
          // If the time difference is within 1 minute, add the function calls to the tasks list
          String subscriptionName = subscriptionDoc['name'];
          String price = subscriptionDoc['amount'];
          tasks.add(uploadInsuranceTransaction(
              currentPhone, price, subscriptionName, 'purpose'));
          tasks.add(
              uploadSubscriptions(currentPhone, price, subscriptionName, "rr"));
        } else {
          if (kDebugMode) {
            print(
                "Nothing to display for subscription: ${subscriptionDoc['name']}");
          }
        }
      }

      await Future.wait(tasks);
    } catch (e) {
      // Handle exceptions here
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  final hasData = false.obs;
  Future<bool> checkQuerySnapshot(String phone) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(manageTransaction)
        .doc(phone)
        .collection("subscriptions")
        .where('name', isEqualTo: name)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      hasData.value = true;
      return true; // QuerySnapshot is not null and has documents
    } else {
      hasData.value = false;
      return false; // QuerySnapshot is null or empty
    }
  }

  Future<void> checkAndNotifyIncomingTransactions() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .get();
      if (!doc.exists) {
        throw 'User document does not exist';
      }
      String currentPhone = doc['phone'];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(manageTransaction)
          .doc(currentPhone)
          .collection('subscriptions')
          .get();

      // Get the current time
      DateTime currentTime = DateTime.now();

      // Define the maximum allowed time difference (29 days)

      // Initialize Flutter Local Notifications plugin

      // Flag to track if any valid transactions were found
      bool anyValidTransaction = false;
      List<Future<void>> tasks = [];
      // Iterate through each transaction using a for loop
      for (var transactionDoc in querySnapshot.docs) {
        // Parse the transaction date from Firestore as a Timestamp
        String timestamp = transactionDoc['date'];
        DateTime transactionDate = DateTime.parse(timestamp);
        print(transactionDate);
        // Calculate the time difference between current time and transaction time
        int timeDifference = currentTime.difference(transactionDate).inDays;
        print(timeDifference);
        // Check if the time difference is within the allowed range
        if (timeDifference >= 30) {
          // If the time difference is greater than or equal to 29 days, trigger a notification
          String transactionName = transactionDoc['name'];
          String amount = transactionDoc['amount'];

          // Construct the notification message
          int notificationId =
              DateTime.now().millisecondsSinceEpoch % 2147483647;
          String notificationMessage = '$transactionName. Amount: Rs $amount ';

          DocumentReference notificationRef = FirebaseFirestore.instance
              .collection('managenotifications')
              .doc(auth.currentUser!.uid)
              .collection('notifications')
              .doc();

          // Construct the notification data
          Map<String, dynamic> notificationData = {
            'message': "Incoming Transaction",
            'amount': transactionDoc['amount'],
            'name': transactionName,
            'date': transactionDoc['date'],
            'timestamp': FieldValue
                .serverTimestamp(), // Use server timestamp to ensure accuracy
          };

          // Save the notification to Firestore
          await notificationRef.set(notificationData);
          tasks.add(showNotification(notificationMessage, notificationId));
          // Show the notification

          // Set the flag to indicate that at least one valid transaction was found
          anyValidTransaction = true;
        }
      }

      // If no valid transactions were found, print a message
      if (!anyValidTransaction) {
        if (kDebugMode) {
          print('No valid transactions found.');
        }
      }
    } catch (e) {
      // Handle exceptions here
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

// Function to show a local notification
  Future<void> showNotification(
      String notificationMessage, int notificationId) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'incoming_transactions_channel', // Channel ID
      'Incoming Transactions', // Channel name

      importance: Importance.max,
      priority: Priority.high,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      notificationId, // Notification ID
      'Incoming Transaction', // Notification title
      notificationMessage, // Notification body
      platformChannelSpecifics,
      payload: 'incoming_transaction',
    );
  }
}
