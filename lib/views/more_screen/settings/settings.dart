import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:unibank/consts/firestore_services.dart';
import 'package:unibank/controller/more_controller.dart';
import 'package:unibank/widgets_common/custom_text_field.dart';
import 'package:unibank/widgets_common/our_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var controller = Get.put(MoreController());
  dynamic data;

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
                return Obx(
                  () => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: Column(
                        children: [
                          10.heightBox,
                          "Update Profile"
                              .text
                              .fontFamily(bold)
                              .size(20)
                              .color(redColor)
                              .bold
                              .make(),
                          25.heightBox,
                          customTextField(
                            controller: controller.nameController,
                            title: name,
                            obsecureText: false,
                          ),
                          10.heightBox,
                          customTextField(
                              controller: controller.phoneController,
                              title: "Phone",
                              obsecureText: false),
                          10.heightBox,
                          customTextField(
                              controller: controller.addressController,
                              title: "Address",
                              obsecureText: false),
                          10.heightBox,
                          customTextField(
                              controller: controller.oldpasswordController,
                              title: "Old Password",
                              obsecureText: true),
                          10.heightBox,
                          customTextField(
                              controller: controller.newpasswordController,
                              title: "New Password",
                              obsecureText: true),
                          40.heightBox,
                          SizedBox(
                              width: context.screenWidth,
                              child: controller.isLoading(false)
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation(redColor),
                                      ),
                                    )
                                  : ourButton(
                                      title: "Save",
                                      textColor: whiteColor,
                                      color: redColor,
                                      onPress: () async {
                                        controller.isLoading(true);

                                        //If old password matched the database
                                        if (data['password'] ==
                                            controller
                                                .oldpasswordController.text) {
                                          await controller.updateAuthPassword(
                                              email: data['email'],
                                              password: controller
                                                  .oldpasswordController.text,
                                              newpass: controller
                                                  .newpasswordController.text);
                                          await controller
                                              .saveUpdatedProfileData(
                                                  name: controller
                                                      .nameController.text,
                                                  password:
                                                      controller
                                                          .newpasswordController
                                                          .text,
                                                  phone:
                                                      controller
                                                          .phoneController.text,
                                                  address: controller
                                                      .addressController.text);

                                          VxToast.show(context,
                                              msg: "Successfully Updated",
                                              bgColor: darkFontGrey,
                                              textColor: whiteColor);
                                        } else {
                                          VxToast.show(context,
                                              msg: "Wrong Old Password!",
                                              bgColor: darkFontGrey,
                                              textColor: whiteColor);
                                          controller.isLoading(false);
                                        }
                                      })),
                        ],
                      )
                          .box
                          .rounded
                          .shadow
                          .white
                          .padding(const EdgeInsets.all(20))
                          .margin(const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 15))
                          .make(),
                    ),
                  ),
                );
              }
            })
        //Main widget)
        );
  }
}
