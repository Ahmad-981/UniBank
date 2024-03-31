import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final bool success;
  final String? message;

  const CustomDialog({super.key, required this.success, this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 190,
        height: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            success
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50,
                  )
                : const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              success
                  ? 'Successfully sent'
                  : message == null
                      ? 'Something went wrong'
                      : message!,
              style: TextStyle(
                color: success ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
