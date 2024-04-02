import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unibank/consts/colors.dart';
import 'package:unibank/views/notification/notification_screen.dart';

const Color shiningBlack = Color(0xFF262525);

// ignore: non_constant_identifier_names
AppBar CustomAppBar(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
        Text(title),
        Container()
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          onTap: () {
            Get.to(() => NotificationScreen(),
                transition: Transition.leftToRightWithFade);
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Gradient shinningColor() {
  return const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      redColor,
      Color(0xFF202020), // Slightly lighter shade of black
    ],
  );
}

String formatNumber(String numberString) {
  // Parse the input string to double
  double number = double.tryParse(numberString) ?? 0.0;
  // Format the number with commas
  return NumberFormat('#,##0', 'en_US').format(number);
}
