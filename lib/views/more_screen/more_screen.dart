import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/colors.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:unibank/consts/firestore_services.dart';
import 'package:unibank/consts/lists.dart';
import 'package:unibank/controller/auth_controller.dart';
import 'package:unibank/controller/home_controller.dart';
import 'package:unibank/views/more_screen/settings/settings.dart';
import 'package:unibank/widgets_common/our_button.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  //var controller = Get.put(AuthController());
  final HomeController controller = Get.put(HomeController());
  List<String> moreList = [
    "Upcoming Events",
    "Saving Locker",
    "Discounts",
    "Privacy Policy",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                //Accessing data is the list
                var data = snapshot.data!.docs[0];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        "assets/images/bg.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // "AHMAD IRTZA"
                            // data['name']
                            controller.currentUser.value!.name
                                .toString()
                                .text
                                .fontFamily(bold)
                                .size(22)
                                .color(redColor)
                                .bold
                                .make(),
                            10.heightBox,
                            controller.currentUser.value!.email
                                .toString()
                                .text
                                .size(15)
                                .fontFamily(semibold)
                                .color(Color.fromARGB(255, 87, 87, 87))
                                .bold
                                .make(),
                            controller.currentUser.value!.phone
                                .toString()
                                .text
                                .size(12)
                                .fontFamily(regular)
                                .color(Color.fromARGB(255, 87, 87, 87))
                                .bold
                                .make(),
                            20.heightBox,

                            20.heightBox,
                            const Divider(
                              thickness: 4,
                              color: lightGrey,
                            ),
                            40.heightBox,
                            ListView.separated(
                              itemCount: moreList.length,
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, index) {
                                return ListTile(
                                  title: moreList[index]
                                      .text
                                      .fontFamily(regular)
                                      .color(darkFontGrey)
                                      .make()
                                      .onTap(() {
                                    Get.to(() => SettingsScreen());
                                  }),
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
                                .padding(
                                    const EdgeInsets.symmetric(horizontal: 16))
                                .shadowSm
                                .make(),
                            (context.screenHeight * 0.09).heightBox,
                            ourButton(
                                color: redColor,
                                title: "Logout",
                                textColor: whiteColor,
                                onPress: () async {
                                  AuthController().loading.value = false;
                                  await controller.logout(context);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
