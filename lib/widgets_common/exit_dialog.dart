import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/widgets_common/our_button.dart';

Widget getExitButtonDialog(context) {
  return Dialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Exit".text.bold.color(darkFontGrey).size(18).make(),
        const Divider(),
        15.heightBox,
        "Do you really want to exit?".text.fontFamily(semibold).size(14).make(),
        25.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                title: "Yes",
                textColor: whiteColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                color: redColor),
            ourButton(
                title: "No",
                textColor: whiteColor,
                onPress: () {
                  Navigator.pop(context);
                },
                color: redColor),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(15)).rounded.make(),
  );
}
