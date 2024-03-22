import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/transaction_controller.dart';
import 'package:unibank/models/money_transfer.dart';
import 'package:unibank/widgets_common/functions.dart';
import 'package:unibank/widgets_common/transaction_containor.dart';

class AllTransactions extends StatelessWidget {
  AllTransactions({Key? key}) : super(key: key);
  final TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: CustomAppBar("All Transactions"),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TransactionContainor(
                    text: "Expenses",
                    transactionController: Get.find<
                        TransactionController>(), // Get the TransactionController instance
                    isSender: true, // Indicate that it represents the sender
                  ),
                  TransactionContainor(
                    text: "Earnings",
                    transactionController: Get.find<
                        TransactionController>(), // Get the TransactionController instance
                    isSender: false, // Indicate that it represents the receiver
                  ),
                ],
              ),
            ),
            Container(
              // Background color of the selected tab
              child: const TabBar(
                indicatorColor: Colors.black,
                // Hide the default indicator
                labelColor: Colors.black, // Color of the selected tab label
                unselectedLabelColor:
                    Colors.grey, // Color of unselected tab labels
                splashBorderRadius: BorderRadius.all(Radius.circular(10)),
                dividerColor: Colors.black,

                tabs: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5), // Adjust padding for each tab
                    child: Tab(text: 'All'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5), // Adjust padding for each tab
                    child: Tab(text: 'Expenses'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6), // Adjust padding for each tab
                    child: Tab(text: 'Earnings'),
                  ),
                ],
              ),
            ),
            10.heightBox,
            Expanded(
              child: DelayedDisplay(
                delay: const Duration(microseconds: 100),
                child: TabBarView(
                  children: [
                    // Contents for Tab 1
                    Obx(() {
                      if (transactionController.isLoading) {
                        return const Center(
                            child: SpinKitHourGlass(
                          color: Colors.black,
                          size: 50,
                        ));
                      } else if (transactionController.transactions.isEmpty) {
                        return const Center(
                          child: EmptyDataWidget(
                            message: "You sent to no one",
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: transactionController.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction =
                                transactionController.transactions[index];
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                transaction.received
                                                    ? Icons.call_received
                                                    : Icons.call_made,
                                                color: transaction.received
                                                    ? Colors.green
                                                    : Colors.red,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, top: 12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                transaction.received
                                                    ? transaction.sender
                                                    : transaction.name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                DateFormat('yyyy-MM-dd')
                                                    .format(transaction.date
                                                        .toDate()!)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              right: 10.0),
                                          child: Center(
                                            child: Text(
                                              "Rs ${formatNumber(transaction.amount)} ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          },
                        );
                      }
                    }),
                    // Contents for Tab 2
                    Obx(() {
                      if (transactionController.isLoading) {
                        return const Center(
                          child: SpinKitHourGlass(
                            color: Colors.black,
                            size: 50,
                          ),
                        );
                      } else if (transactionController.transactions.isEmpty) {
                        return const Center(
                          child: EmptyDataWidget(
                            message: "You sent to no one",
                          ),
                        );
                      } else {
                        // Filter transactions where received is true
                        final List<MoneyTransfer> receivedTransactions =
                            transactionController.transactions
                                .where((transaction) => !transaction.received)
                                .toList();
                        if (receivedTransactions.isEmpty) {
                          return const Center(
                            child: EmptyDataWidget(
                              message: "No received transactions found",
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: receivedTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction = receivedTransactions[index];
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  transaction.received
                                                      ? Icons.call_received
                                                      : Icons.call_made,
                                                  color: transaction.received
                                                      ? Colors.green
                                                      : Colors.red,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, top: 12),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  transaction.received
                                                      ? transaction.sender
                                                      : transaction.name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(transaction.date
                                                          .toDate()!)
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              right: 10.0,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Rs ${formatNumber(transaction.amount)} ",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),

                    // Contents for Tab 3
                    Obx(() {
                      if (transactionController.isLoading) {
                        return const Center(
                          child: SpinKitHourGlass(
                            color: Colors.black,
                            size: 50,
                          ),
                        );
                      } else if (transactionController.transactions.isEmpty) {
                        return const Center(
                          child: EmptyDataWidget(
                            message: "You sent to no one",
                          ),
                        );
                      } else {
                        // Filter transactions where received is true
                        final List<MoneyTransfer> receivedTransactions =
                            transactionController.transactions
                                .where((transaction) => transaction.received)
                                .toList();
                        if (receivedTransactions.isEmpty) {
                          return const Center(
                            child: EmptyDataWidget(
                              message: "No received transactions found",
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: receivedTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction = receivedTransactions[index];
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.call_received,
                                                  color: Colors.green,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, top: 12),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  transaction.received
                                                      ? transaction.sender
                                                      : transaction.name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(transaction.date
                                                          .toDate()!)
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              right: 10.0,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Rs ${formatNumber(transaction.amount)} ",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyDataWidget extends StatelessWidget {
  final String message;
  const EmptyDataWidget({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          message,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
