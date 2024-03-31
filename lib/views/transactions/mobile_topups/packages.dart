import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/electricity_controller.dart';
import 'package:unibank/views/transactions/insurance/select_insurance.dart';
import 'package:unibank/views/transactions/mobile_topups/pay_packages.dart';
import 'package:unibank/widgets_common/functions.dart';

class MobilePackages extends StatelessWidget {
  final ElectricityBillController controller =
      Get.put(ElectricityBillController());
  final TextEditingController _moneyController = TextEditingController();
  MobilePackages({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: CustomAppBar("Packages"),
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
                  "Select  Package",
                  style: TextStyle(fontSize: 18, fontFamily: bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Obx(() => ListView.builder(
                        itemCount: controller.filteredInsuranceProviders.length,
                        itemBuilder: (context, index) {
                          return DelayedDisplay(
                            delay: const Duration(microseconds: 100),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.23,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 231, 230, 230),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 8),
                                          child: Text(
                                            controller.packages[index],
                                            style: const TextStyle(
                                              color: redColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        10.heightBox,
                                        Row(
                                          children: [
                                            MyPackage(
                                              icon: Icons.phone_callback,
                                              value:
                                                  "${controller.minutes[index]}\nminutes",
                                            ),
                                            30.widthBox,
                                            MyPackage(
                                              icon: Icons.message_outlined,
                                              value:
                                                  "${controller.messages[index]}\nSMS",
                                            ),
                                            30.widthBox,
                                            MyPackage(
                                              icon: Icons.signal_cellular_alt,
                                              value:
                                                  "${controller.gbs[index]}\nData",
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 14.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Rs ${controller.packagesPrice[index]}",
                                                    style: const TextStyle(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  7.widthBox,
                                                  const Text(
                                                    "load amount",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  )
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () => PackagePayment(
                                                            packageName:
                                                                controller
                                                                        .packages[
                                                                    index],
                                                            price: controller
                                                                    .packagesPrice[
                                                                index],
                                                          ),
                                                      transition: Transition
                                                          .leftToRightWithFade,
                                                      duration: const Duration(
                                                          milliseconds: 400));
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20),
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      color: redColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                "validity: ",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                  "  ${controller.packagesValidity[index]} days"),
                                            ],
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

class MyPackage extends StatelessWidget {
  final String value;
  final IconData icon;
  const MyPackage({
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        5.heightBox,
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            value,
            style: const TextStyle(height: 1.3),
          ),
        )
      ],
    );
  }
}
