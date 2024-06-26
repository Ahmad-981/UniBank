import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/electricity_controller.dart';
import 'package:unibank/views/transactions/insurance/select_insurance.dart';
import 'package:unibank/widgets_common/functions.dart';

class Insurance extends StatelessWidget {
  final ElectricityBillController controller =
      Get.put(ElectricityBillController());
  final TextEditingController _moneyController = TextEditingController();
  Insurance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Insurance"),
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
                  "Select or Search Insurances",
                  style: TextStyle(fontSize: 18, fontFamily: bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: TextField(
                      controller: _moneyController,
                      decoration: InputDecoration(
                        //contentPadding: const EdgeInsets.all(13),
                        hintText: 'Type here .........',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: redColor), // Border color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: redColor), // Border color when focused
                        ),
                      ),
                      onChanged: (value) {
                        controller.searchInsuranceProviders(value);
                      },
                    ),
                  ),
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
                                              backgroundColor:
                                                  redColor, // Make background transparent
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: redColor,
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
                                                        .filteredInsuranceProviders[
                                                    index],
                                                style: const TextStyle(
                                                  color: redColor,
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
                                                () => SelectInsurance(
                                                      phone: controller
                                                              .filteredInsuranceProvidersPrice[
                                                          index],
                                                      provide: controller
                                                              .filteredInsuranceProviders[
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
                                                color: redColor,
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
