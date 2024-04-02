import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/notification_controller.dart';
import 'package:unibank/controller/transaction_controller.dart';
import 'package:unibank/widgets_common/functions.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController transactionController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Notifications"),
      body: Column(
        children: [
          10.heightBox,
          const Text(
            "Upcoming Transactions",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
          ),
          10.heightBox,
          Expanded(
            child: DelayedDisplay(
              delay: const Duration(microseconds: 100),
              child: Obx(() {
                if (transactionController.isLoading) {
                  return const Center(
                      child: SpinKitHourGlass(
                    color: redColor,
                    size: 50,
                  ));
                } else if (transactionController.transactions.isEmpty) {
                  return const Center(
                    child: EmptyDataWidget(
                      message: "Nothing to Show",
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
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
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
                                        left: 10.0, top: 12),
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
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('yyyy-MM-dd')
                                              .format(
                                                  transaction.date.toDate()!)
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        right: 10.0),
                                    child: Center(
                                      child: Text(
                                        "\$${formatNumber(transaction.amount)} ",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
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
            ),
          ),
        ],
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
      padding: const EdgeInsets.only(left: 15),
      height: 100,
      width: 250,
      decoration: BoxDecoration(
          color: redColor, borderRadius: BorderRadius.circular(20)),
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
