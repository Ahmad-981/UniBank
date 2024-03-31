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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var loading = false.obs;
  var controller = Get.put(AuthController());
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    // (context.screenHeight * 0.05).heightBox,
                    (context.screenHeight * 0.05).heightBox,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/food2.PNG",
                          width: 200,
                          fit: BoxFit.fill,
                        ).box.shadow.roundedFull.clip(Clip.antiAlias).make(),
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
                                title: name,
                                controller: nameController,
                                obsecureText: false,
                                icon: const Icon(Icons.person, color: redColor)),
                            15.heightBox,
                            customTextField(
                                title: email,
                                controller: emailController,
                                obsecureText: false,
                                icon: const Icon(Icons.email_outlined,
                                    color: redColor)),
                            15.heightBox,
                            customTextField(
                                title: "Phone",
                                controller: phoneController,
                                obsecureText: false,
                                icon: const Icon(Icons.call, color: redColor)),
                            15.heightBox,
                            customTextField(
                              title: "Address",
                              controller: addressController,
                              obsecureText: false,
                              icon: const Icon(
                                Icons.home_outlined,
                                color: redColor,
                              ),
                            ),
                            15.heightBox,
                            customTextField(
                              title: password,
                              controller: passwordController,
                              obsecureText: true,
                              icon: const Icon(
                                Icons.lock_outline,
                                color: redColor,
                              ),
                            ),
                            15.heightBox,
                            // customTextField(
                            //   title: "Confirm Password",
                            //   controller: confirmPasswordController,
                            //   obsecureText: true,
                            //   icon: Icon(
                            //     Icons.lock_outline,
                            //     color: redColor,
                            //   ),
                            // ),
                            25.heightBox,
                            controller.loading.value
                                ? const CircularProgressIndicator()
                                : ourButton(
                                        title: signup,
                                        color: redColor,
                                        textColor: whiteColor,
                                        onPress: () async {
                                          controller.loading.value = true;
                                          try {
                                            await controller
                                                .signUp(
                                                    context: context,
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text)
                                                .then((value) {
                                              if (value!.user!.emailVerified) {
                                                return controller
                                                    .storageUserData(
                                                        email: emailController
                                                            .text,
                                                        phone: phoneController
                                                            .text,
                                                        address:
                                                            addressController
                                                                .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        name: nameController
                                                            .text);
                                              } else {
                                                controller.storageUserData(
                                                    email: emailController.text,
                                                    phone: phoneController.text,
                                                    address:
                                                        addressController.text,
                                                    password:
                                                        passwordController.text,
                                                    name: nameController.text);
                                                // Email is not verified, inform the user
                                                // VxToast.show(context,
                                                //     msg:
                                                //         'Please verify your email to access the home page.');
                                              }
                                            }).then((value) {
                                              controller.loading.value = false;
                                              controller.logout(context);
                                              // VxToast.show(context,
                                              //     msg:
                                              //         "User Created Successfully",
                                              //     showTime: 5000,
                                              //     bgColor: fontGrey,
                                              //     textColor: whiteColor);
                                              // Get.offAll(() => const Home());
                                            });
                                          } catch (e) {
                                            controller.loading.value = false;
                                            controller.logout(context);
                                            VxToast.show(
                                              context,
                                              msg: e.toString(),
                                            );
                                            // bgColor: Colors.black,
                                            // textColor: whiteColor
                                          }
                                        })
                                    .box
                                    .shadow
                                    .width(context.screenWidth - 50)
                                    .make(),
                            10.heightBox,
                            "Or".text.color(darkFontGrey).make(),
                            10.heightBox,
                            ourButton(
                                    title: login,
                                    color: whiteColor,
                                    textColor: redColor,
                                    onPress: () async {
                                      Get.to(() => const LoginScreen());
                                    })
                                .box
                                .shadowSm
                                .width(context.screenWidth - 50)
                                .make(),
                            15.heightBox,
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
