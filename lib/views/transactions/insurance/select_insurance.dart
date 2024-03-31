import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/transfer_controller.dart';
import 'package:unibank/models/user_model.dart';
import 'package:unibank/views/transactions/insurance/pay_insurance.dart';
import 'package:unibank/widgets_common/dialoge_box.dart';
import 'package:unibank/widgets_common/functions.dart';
import 'package:unibank/widgets_common/submit_button.dart';

class SelectInsurance extends StatelessWidget {
  SelectInsurance({super.key, required this.phone, required this.provide});
  final TextEditingController _moneyController = TextEditingController();
  final UserController userController = Get.put(UserController());
  final String provide;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Select"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8),
              child: Text(
                "Insurance",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 12),
              child: Text(
                "Rs $phone per month",
                style: const TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
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
                        SizedBox(
                          width: 200,
                          height: 100,
                          child: TextFormField(
                            controller: _moneyController,
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'xxxxxxxxxxx',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: semibold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "Enter 11 Digit phone number\nfor the verification",
                          style: TextStyle(
                              color: Colors.white,
                              //fontWeight: FontWeight.normal,
                              fontSize: 12,
                              fontFamily: bold),
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
                  text: "Fetch details",
                  width: MediaQuery.of(context).size.width * 1,
                  ontap: () async {
                    if (_moneyController.text.isNotEmpty &&
                        _moneyController.text.length == 11) {
                      User? user = await userController
                          .getUserByPhone(_moneyController.text);
                      if (user != null) {
                        // User found, do something with the user data
                        Get.to(
                            () => PayInsurance(
                                  provider: provide,
                                  phone: _moneyController.text,
                                  name: provide,
                                  price: phone,
                                ),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 400));
                      } else {
                        Get.dialog(const DelayedDisplay(
                          delay: Duration(microseconds: 100),
                          child: CustomDialog(
                            success: false,
                            message: "Number is wrong!",
                          ),
                        ));
                      }
                    } else {
                      Get.dialog(const DelayedDisplay(
                        delay: Duration(microseconds: 100),
                        child: CustomDialog(
                          success: false,
                          message: "Please Enter Valid Number",
                        ),
                      ));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
