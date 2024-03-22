import 'package:flutter/material.dart';

class CustomSmallButton extends StatelessWidget {
  const CustomSmallButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      width: 80,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: const Center(
        child: Text(
          "View More",
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ),
    );
  }
}
