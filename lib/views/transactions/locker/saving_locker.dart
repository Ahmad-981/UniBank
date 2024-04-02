import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/money_transfer_controller.dart';
import 'package:unibank/controller/transfer_controller.dart';
import 'package:unibank/views/home_screen/home_screen.dart';
import 'package:unibank/widgets_common/dialoge_box.dart';
import 'package:unibank/widgets_common/functions.dart';
import 'package:unibank/widgets_common/submit_button.dart';

class SavingLocker extends StatelessWidget {
  SavingLocker({
    required this.phoneNumber,
    super.key,
  });
  final TextEditingController _moneyController = TextEditingController();

  final UserController userController = Get.put(UserController());
  final MoneyTransferController moneyTransferController =
      Get.put(MoneyTransferController());
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: CustomAppBar("Saving Locker"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 8),
                child: Text(
                  "Transfer to Saving Locker",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 12),
                child: Text(
                  "Enter Amount",
                  style: TextStyle(fontSize: 15, fontFamily: semibold),
                ),
              ),
              Container(
                height: 130,
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
                          Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  "assets/images/bg.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 55,
                                child: TextFormField(
                                  controller: _moneyController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Rs.   xxx',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: regular),
                                  ),
                                ),
                              ),
                            ],
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
                      text: "Subscibe Money Saver ",
                      width: MediaQuery.of(context).size.width * 1,
                      ontap: () async {
                        if (_moneyController.text.isNotEmpty &&
                            int.tryParse(_moneyController.text) != null &&
                            int.parse(_moneyController.text) > 0) {
                          await userController.uploadInsuranceTransaction(
                              phoneNumber,
                              _moneyController.text,
                              "Money Saver",
                              'saving money');
                          await userController.uploadSubscriptions(
                              phoneNumber,
                              _moneyController.text,
                              "Money Saver",
                              'saving money');
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
