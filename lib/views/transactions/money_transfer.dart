import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/electricity_controller.dart';
import 'package:unibank/views/transactions/send_money.dart';
import 'package:unibank/widgets_common/functions.dart';

class TransferMoney extends StatelessWidget {
  final ElectricityBillController controller =
      Get.put(ElectricityBillController());
  final TextEditingController _moneyController = TextEditingController();
  TransferMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Transfer"),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Transfer to Bank Accounts",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 30,
                  child: Center(
                    child: TextField(
                      controller: _moneyController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(13),
                        hintText: 'Search or select bank',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors
                                  .black), // Border color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.black), // Border color when focused
                        ),
                      ),
                      onChanged: (value) {
                        controller.searchTranferProviders(value);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Obx(() => ListView.builder(
                        itemCount: controller.filteredTransferProviders.length,
                        itemBuilder: (context, index) {
                          return DelayedDisplay(
                            delay: const Duration(microseconds: 100),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 70,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundImage: const AssetImage(
                                                'assets/images/food2.PNG',
                                              ),
                                              backgroundColor: Colors
                                                  .black, // Make background transparent
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: Image.asset(
                                                    'assets/images/food2.PNG',
                                                    fit: BoxFit
                                                        .cover, // Ensure the image covers the entire circle
                                                  ),
                                                ),
                                              ),
                                            ),
                                            10.widthBox,
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0, top: 5),
                                              child: Text(
                                                controller
                                                        .filteredTransferProviders[
                                                    index],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                                () => SendMoneyTo(
                                                      provider: controller
                                                              .filteredTransferProviders[
                                                          index],
                                                    ),
                                                transition: Transition
                                                    .leftToRightWithFade,
                                                duration: const Duration(
                                                    milliseconds: 400));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 20),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.call_made,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
