import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/transfer_controller.dart';
import 'package:unibank/models/user_model.dart';
import 'package:unibank/views/transactions/enter_amount.dart';
import 'package:unibank/widgets_common/dialoge_box.dart';
import 'package:unibank/widgets_common/functions.dart';
import 'package:unibank/widgets_common/submit_button.dart';

class SendMoneyTo extends StatelessWidget {
  SendMoneyTo({super.key, required this.provider});
  final TextEditingController _moneyController = TextEditingController();
  final UserController userController = Get.put(UserController());
  final String provider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Money Transfer"),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 8),
                  child: Text(
                    "Transfer to Bank Account",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                10.heightBox,
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 12),
                  child: Text(
                    "Enter Account Number",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.heightBox,
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: TextFormField(
                                controller: _moneyController,
                                keyboardType: TextInputType.number,
                                maxLength: 11, // Limit maximum to 11 digits
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'XXXXXXXXXXX',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 206, 205, 205),
                                    fontSize: 15,
                                    fontFamily: regular,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text(
                              "Enter 11 Digit account number\nthat you are provided with",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.payment,
                              color: redColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: CustomSubmitButton(
                      isLoading: userController.isLoading.value,
                      text: "Add Bank Account Number ",
                      width: MediaQuery.of(context).size.width * 1,
                      ontap: () async {
                        if (_moneyController.text.isNotEmpty) {
                          User? user = await userController
                              .getUserByPhone(_moneyController.text);
                          if (user != null) {
                            // User found, do something with the user data
                            Get.to(
                                () => EnterAmount(
                                      provider: provider,
                                      name: user.name,
                                      phone: user.phone,
                                    ),
                                transition: Transition.leftToRightWithFade,
                                duration: const Duration(milliseconds: 400));
                          } else {
                            Get.dialog(const DelayedDisplay(
                                delay: Duration(microseconds: 100),
                                child: CustomDialog(
                                  success: false,
                                  message: "Account Number is Wrong",
                                )));
                          }
                        } else {
                          Get.dialog(const DelayedDisplay(
                              delay: Duration(microseconds: 100),
                              child: CustomDialog(
                                success: false,
                                message:
                                    "We Cannot Send Money to Void.\nWrite Account Number",
                              )));
                        }
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
