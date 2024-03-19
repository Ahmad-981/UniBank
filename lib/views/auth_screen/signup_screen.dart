// import 'package:emart_app/consts/lists.dart';
// import 'package:emart_app/views/auth_screen/signup_screen.dart';
// import 'package:emart_app/views/home_screen/home.dart';
import 'package:unibank/views/auth_screen/login_screen.dart';
import 'package:unibank/views/home_screen/home.dart';
import 'package:unibank/widgets_common/custom_text_field.dart';
import 'package:unibank/widgets_common/our_button.dart';
import 'package:unibank/widgets_common/our_button2.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/consts/colors.dart';
import 'package:unibank/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var loading = false.obs;
  var controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // (context.screenHeight * 0.05).heightBox,
                (context.screenHeight * 0.05).heightBox,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/food2.PNG",
                      width: 200,
                      fit: BoxFit.fill,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
                  ],
                ),
                (context.screenHeight * 0.03).heightBox,
                "Welcome to UniBank"
                    .text
                    .color(const Color.fromARGB(255, 94, 92, 92))
                    .semiBold
                    .fontFamily(semibold)
                    .size(17)
                    .make(),

                "Register an Account"
                    .text
                    .color(redColor)
                    .fontFamily(semibold)
                    .size(12)
                    .semiBold
                    .make(),
                // 5.heightBox,
                Obx(() => Column(
                      children: [
                        customTextField(
                            title: email,
                            controller: controller.emailController,
                            obsecureText: false,
                            icon: Icon(Icons.email_outlined, color: redColor)),
                        15.heightBox,
                        customTextField(
                            title: "Phone",
                            controller: controller.emailController,
                            obsecureText: false,
                            icon: Icon(Icons.call, color: redColor)),
                        15.heightBox,
                        customTextField(
                          title: password,
                          controller: controller.passwordController,
                          obsecureText: true,
                          icon: Icon(
                            Icons.lock_outline,
                            color: redColor,
                          ),
                        ),
                        15.heightBox,
                        customTextField(
                          title: "Confirm Password",
                          controller: controller.passwordController,
                          obsecureText: true,
                          icon: Icon(
                            Icons.lock_outline,
                            color: redColor,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: forgetPassword.text
                                  .fontFamily(semibold)
                                  .size(12)
                                  .color(redColor)
                                  .make()),
                        ),
                        5.heightBox,
                        controller.loading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : ourButton(
                                    title: signup,
                                    color: redColor,
                                    textColor: whiteColor,
                                    onPress: () async {
                                      // controller.loading.value = true;
                                      // try {
                                      //   await controller
                                      //       .signIn(context: context)
                                      //       .then((value) {
                                      //     if (value != null) {
                                      //       VxToast.show(context,
                                      //           msg: "Login Successfully",
                                      //           showTime: 5000,
                                      //           bgColor: fontGrey,
                                      //           textColor: whiteColor);
                                      Get.to(() => const Home());
                                      //     } else {
                                      //       controller.loading.value = false;
                                      //     }
                                      //   });
                                      // } catch (e) {
                                      //   VxToast.show(context,
                                      //       msg: e.toString(),
                                      //       showTime: 5000,
                                      //       pdVertical: 40);
                                      // }
                                    })
                                .box
                                .shadow
                                .width(context.screenWidth - 50)
                                .make(),
                        10.heightBox,
                        "Or".text.color(darkFontGrey).make(),
                        10.heightBox,
                        controller.loading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : ourButton(
                                    title: login,
                                    color: whiteColor,
                                    textColor: redColor,
                                    onPress: () async {
                                      Get.to(() => LoginScreen());
                                    })
                                .box
                                .shadowSm
                                .width(context.screenWidth - 50)
                                .make(),
                        15.heightBox,
                      ],
                    ).box.padding(EdgeInsets.all(25)).make()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
