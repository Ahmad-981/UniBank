import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/colors.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/auth_controller.dart';
import 'package:unibank/widgets_common/our_button.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            "AHMAD IRTZA"
                .text
                .fontFamily(bold)
                .size(20)
                .color(redColor)
                .bold
                .make(),
            10.heightBox,
            "+92 320 8565130"
                .text
                .size(15)
                .fontFamily(semibold)
                .color(Color.fromARGB(255, 87, 87, 87))
                .bold
                .make(),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                "Balance"
                    .text
                    .fontFamily(semibold)
                    .size(16)
                    .color(redColor)
                    .bold
                    .make(),
                10.heightBox,
                "\$200.00"
                    .text
                    .size(20)
                    .fontFamily(bold)
                    .color(Color.fromARGB(255, 87, 87, 87))
                    .bold
                    .make(),
              ],
            ),
            20.heightBox,
            const Divider(
              thickness: 4,
              color: lightGrey,
            ),
            40.heightBox,
            ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  // leading: Image.asset(
                  //   profileButtonIcons[index],
                  //   width: 22,
                  // ),
                  title: "Account History"
                      .text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .make(),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 4,
                  color: lightGrey,
                );
              },
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.symmetric(horizontal: 16))
                .shadowSm
                .make(),
            (context.screenHeight * 0.09).heightBox,
            ourButton(
                color: redColor,
                title: "Logout",
                textColor: whiteColor,
                onPress: () async {
                  controller.loading.value = false;
                  await controller.logout(context);
                }),
          ],
        ),
      ),
    );
  }
}
