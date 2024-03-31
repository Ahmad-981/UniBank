import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/colors.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/money_transfer_controller.dart';
import 'package:unibank/widgets_common/dialoge_box.dart';
import 'package:unibank/widgets_common/functions.dart';
import 'package:unibank/widgets_common/submit_button.dart';

class AddMoney extends StatelessWidget {
  AddMoney({super.key});

  final MoneyTransferController controller = Get.put(MoneyTransferController());

  final TextEditingController _moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar("Enter Amount"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: height * 0.17,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Money Transfer Statistics ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You have Spent 10% more this month\n as compared to Last one",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 9),
                          //CustomSmallButton(),
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
                            Icons.arrow_circle_right_outlined,
                            color: redColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DelayedDisplay(
                delay: const Duration(microseconds: 200),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.2,
                      left: width * 0.19,
                      right: width * 0.1),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.6,
                        height: 60,
                        child: TextFormField(
                          controller: _moneyController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: darkFontGrey,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter Amount',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 109, 108, 108),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            suffix: Container(
                              height: 20,
                              width: 30,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Center(
                                child: Text(
                                  "USD",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.17),
              Obx(() {
                return DelayedDisplay(
                  delay: const Duration(microseconds: 100),
                  child: CustomSubmitButton(
                    width: width,
                    text: "Add Money",
                    ontap: () {
                      if (_moneyController.text.isNotEmpty &&
                          int.parse(_moneyController.text) > 0) {
                        String amount = _moneyController.text;
                        controller.sendMoney(amount);
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
                    isLoading: controller.isLoading.value,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
