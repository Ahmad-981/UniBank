import 'package:unibank/consts/consts.dart';
import 'package:flutter/material.dart';

Widget ourButton({String? title, textColor, onPress, color}) {
  return RawMaterialButton(
    onPressed: onPress,
    elevation: 2.0, // Add elevation if needed
    fillColor: color,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(10), // Adjust the border radius as needed
    ),
    padding: const EdgeInsets.all(17),
    child: Center(
      child: title!.text.color(textColor).semiBold.make(),
    ),
  );

  // ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //         backgroundColor: color, padding: const EdgeInsets.all(12)),
  //     onPressed: onPress,
  //     child: title!.text.color(textColor).fontFamily(bold).make());
}
