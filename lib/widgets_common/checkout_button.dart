import 'package:unibank/consts/consts.dart';
import 'package:flutter/material.dart';

Widget checkoutButton({String? title, textColor, onPress, color, icon}) {
  return RawMaterialButton(
    onPressed: onPress,
    elevation: 2.0, // Add elevation if needed

    fillColor: color,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(8), // Adjust the border radius as needed
    ),
    padding: const EdgeInsets.all(15),
    child: Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.delivery_dining,
          color: whiteColor,
        ),
        10.widthBox,
        title!.text.color(textColor).semiBold.make(),
      ],
    )),
  )
      .box
      .rounded

      // .shadow
      .padding(const EdgeInsets.symmetric(horizontal: 8))
      .make();
}
