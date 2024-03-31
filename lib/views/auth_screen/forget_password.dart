// import 'package:emart_app/consts/lists.dart';
// import 'package:emart_app/views/auth_screen/signup_screen.dart';
// import 'package:emart_app/views/home_screen/home.dart';
import 'package:unibank/views/auth_screen/login_screen.dart';
import 'package:unibank/widgets_common/custom_text_field.dart';
import 'package:unibank/widgets_common/our_button.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import '../home_screen/home.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var loading = false.obs;
  var controller = Get.put(AuthController());
  final forgetPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Color.fromARGB(255, 170, 170, 170),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/bg.png",
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    (context.screenHeight * 0.2).heightBox,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/food2.PNG",
                          width: 250,
                          fit: BoxFit.fill,
                        ).box.shadow.roundedFull.clip(Clip.antiAlias).make(),
                      ],
                    ),
                    (context.screenHeight * 0.03).heightBox,
                    "Enter your Email"
                        .text
                        .color(const Color.fromARGB(255, 94, 92, 92))
                        .semiBold
                        .fontFamily(semibold)
                        .size(17)
                        .make(),

                    "We will send you a verification link at your Email"
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
                                controller: forgetPasswordController,
                                obsecureText: false,
                                icon: const Icon(Icons.email_outlined,
                                    color: redColor)),
                            35.heightBox,
                            controller.loading.value
                                ? const CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(redColor),
                                  )
                                : ourButton(
                                        title: "Send Code",
                                        color: redColor,
                                        textColor: whiteColor,
                                        onPress: () async {
                                          //Get.to(() => const Home());
                                          controller.loading.value = true;
                                          try {
                                            await controller
                                                .forgetPassword(
                                                    context: context,
                                                    email:
                                                        forgetPasswordController
                                                            .text)
                                                .then((value) {
                                              if (value != null) {
                                                VxToast.show(context,
                                                    msg: "Check Your Email",
                                                    showTime: 5000,
                                                    bgColor: fontGrey,
                                                    textColor: whiteColor);
                                                Get.to(
                                                    () => const LoginScreen());
                                              } else {
                                                Get.to(
                                                    () => const LoginScreen());
                                                controller.loading.value =
                                                    false;
                                              }
                                            });
                                          } catch (e) {
                                            VxToast.show(context,
                                                msg: e.toString(),
                                                showTime: 5000,
                                                pdVertical: 40);
                                          }
                                        })
                                    .box
                                    .shadow
                                    .width(context.screenWidth - 50)
                                    .make(),
                            10.heightBox,
                          ],
                        ).box.padding(const EdgeInsets.all(25)).make()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
