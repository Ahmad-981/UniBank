import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class CustomSubmitButton extends StatelessWidget {
  CustomSubmitButton({
    super.key,
    required this.width,
    required this.text,
    required this.ontap,
    this.isLoading = false,
  });

  final double width;
  final VoidCallback ontap;
  bool isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: width * 0.9,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: isLoading
              ? const SpinKitFadingCircle(
                  color: Colors.white,
                  size: 30.0,
                )
              : Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
