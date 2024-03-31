import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/transfer_controller.dart';
import 'package:unibank/views/home_screen/home_screen.dart';
import 'package:unibank/widgets_common/dialoge_box.dart';
import 'package:unibank/widgets_common/functions.dart';
import 'package:unibank/widgets_common/submit_button.dart';

class PayInsurance extends StatelessWidget {
  PayInsurance(
      {super.key,
      required this.provider,
      required this.price,
      required this.name,
      required this.phone});
  final TextEditingController _purposeController = TextEditingController();
  final UserController userController = Get.put(UserController());
  final String phone;
  final String price;
  final String name;
  final String provider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Insurance"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                child: Text(
                  "Transfer to Insurance Account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rs.  $price",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          10.heightBox,
                          const Text(
                            "To",
                            style: TextStyle(color: Colors.white),
                          ),
                          5.heightBox,
                          Container(
                            width: 200,
                            height: 1,
                            color: Colors.white,
                          ),
                          10.heightBox,
                          Row(
                            children: [
                              SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                      "assets/images/insurance.png")),
                              10.widthBox,
                              Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          40.heightBox,
                          Container(
                            width: 200,
                            height: 1,
                            color: Colors.white,
                          ),
                          10.heightBox,
                          const Text(
                            "Write Purpose",
                            style: TextStyle(color: Colors.white),
                          ),
                          5.heightBox,
                          SizedBox(
                            width: 200,
                            height: 35,
                            child: TextFormField(
                              controller: _purposeController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: const InputDecoration(
                                hintText: '_ _ _ _ _ _',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const HomeScreen(),
                              transition: Transition.leftToRightWithFade,
                              duration: const Duration(milliseconds: 400));
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.home,
                              color: redColor,
                            ),
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
                child: Obx(() => CustomSubmitButton(
                      isLoading: userController.isLoading.value,
                      text: "Subscribe ",
                      width: MediaQuery.of(context).size.width * 1,
                      ontap: () async {
                        if (_purposeController.text.isEmpty) {
                          Get.dialog(const DelayedDisplay(
                            delay: Duration(microseconds: 100),
                            child: CustomDialog(
                              success: false,
                              message: "Select Date for later purposes",
                            ),
                          ));
                        } else if (_purposeController.text.isNotEmpty) {
                          await userController.uploadInsuranceTransaction(
                              phone, price, name, _purposeController.text);

                          await userController.uploadSubscriptions(
                              phone, price, name, _purposeController.text);
                          // await userController
                          //     .checkAndPrintRecentSubscriptions(phone);
                        } else {
                          Get.dialog(const DelayedDisplay(
                            delay: Duration(microseconds: 100),
                            child: CustomDialog(
                              success: false,
                              message: "Invalid Amount",
                            ),
                          ));
                        }
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
