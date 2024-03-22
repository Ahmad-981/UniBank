import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/controller/transaction_controller.dart'; // Import Get for Obx

class TransactionContainor extends StatelessWidget {
  final String text;
  final TransactionController
      transactionController; // Add TransactionController
  final bool isSender; // Add isSender parameter
  const TransactionContainor({
    super.key,
    required this.text,
    required this.transactionController,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 190,
          width: 165,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: const DecorationImage(
              colorFilter: ColorFilter.srgbToLinearGamma(),
              image: AssetImage(
                  'assets/images/graph.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 45,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(0.9), // Adjust opacity as needed
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Rs ${isSender ? transactionController.totalSent : transactionController.totalReceived} ", // Use totalSent or totalReceived based on isSender
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
