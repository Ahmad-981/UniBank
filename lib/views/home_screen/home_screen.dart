import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restart_app/restart_app.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/home_controller.dart';
import 'package:unibank/main.dart';
import 'package:unibank/views/transactions/add_transaction.dart';
import 'package:unibank/views/transactions/all_transaction.dart';
import 'package:unibank/views/transactions/bills/electricity.dart';
import 'package:unibank/views/transactions/bills/gas_bills.dart';
import 'package:unibank/views/transactions/bills/water_bills.dart';
import 'package:unibank/views/transactions/money_transfer.dart';
// import 'package:taco/views/home_screen/truck_info/truck_screen.dart';
import 'package:unibank/widgets_common/functions.dart';
// import 'package:taco/widgets_common/map_search.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("UniBank"),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(children: [
                    //(context.screenHeight * 0.07).heightBox,
                    Row(
                      children: [
                        5.widthBox,
                        Expanded(
                            child: DelayedDisplay(
                          delay: const Duration(microseconds: 50),
                          child: Obx(() {
                            final HomeController controller =
                                Get.find<HomeController>();
                            return Container(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 1, bottom: 20),
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  10.heightBox,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: const AssetImage(
                                              'assets/images/food2.PNG',
                                            ),
                                            backgroundColor: Colors
                                                .transparent, // Make background transparent
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              10.widthBox,
                                              "Welcome Aboard"
                                                  .text
                                                  .size(12)
                                                  .color(whiteColor)
                                                  .make(),
                                              10.widthBox,
                                              controller.currentUser.value ==
                                                      null
                                                  ? "Sherlock"
                                                      .text
                                                      .size(14)
                                                      .color(whiteColor)
                                                      .bold
                                                      .make()
                                                  : controller.currentUser
                                                      .value!.name.text
                                                      .size(14)
                                                      .color(whiteColor)
                                                      .bold
                                                      .make(),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  10.heightBox,
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child:
                                            "Rs     ${controller.amount!.value}"
                                                .text
                                                .size(27)
                                                .color(whiteColor)
                                                .bold
                                                .fontWeight(FontWeight.w900)
                                                .make(),
                                      ),
                                      20.widthBox,
                                      InkWell(
                                          onTap: () {
                                            controller
                                                .fetchUserDataFromFirestore();
                                          },
                                          child: const Icon(
                                            Icons.refresh,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                  15.heightBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => AddMoney(),
                                              transition: Transition
                                                  .leftToRightWithFade);
                                        },
                                        child: Container(
                                          height: 27,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                                5.widthBox,
                                                const Text(
                                                  "Add Money",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 27,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.account_circle_outlined,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                                5.widthBox,
                                                const Text(
                                                  "My Account",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                        )),
                      ],
                    )
                        .box
                        //.padding(EdgeInsets.symmetric(horizontal: 10))
                        .make(),

                    20.heightBox,
                    "What we offer?"
                        .text
                        .size(15)
                        .color(const Color.fromARGB(255, 87, 87, 87))
                        .bold
                        .make(),
                    20.heightBox,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => TransferMoney(),
                                transition: Transition.leftToRightWithFade,
                                duration: const Duration(milliseconds: 450));
                          },
                          child: const UtilisContainors(
                            text: "Money\nTransfer",
                            image: "assets/images/send.png",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                width: MediaQuery.of(context).size.width,

                                height: 200,
                                // Set width to screen width
                                // Define the content of your bottom sheet here
                                child: Column(
                                  mainAxisSize: MainAxisSize
                                      .min, // Set to min to occupy minimum height
                                  children: [
                                    // Add any widgets you want to display in the bottom sheet
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 60.0, top: 20, right: 20),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => ElectricityBill(),
                                                  transition: Transition
                                                      .leftToRightWithFade,
                                                  duration: const Duration(
                                                      milliseconds: 450));
                                            },
                                            child: const UtilisContainors(
                                              text: "Electricity\nBills",
                                              image: "assets/images/bank.png",
                                            ),
                                          ),
                                          30.widthBox,
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => WaterBills(),
                                                  transition: Transition
                                                      .leftToRightWithFade,
                                                  duration: const Duration(
                                                      milliseconds: 450));
                                            },
                                            child: const UtilisContainors(
                                              text: "Water\nBills",
                                              image: "assets/images/bill.png",
                                            ),
                                          ),
                                          30.widthBox,
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => GasBill(),
                                                  transition: Transition
                                                      .leftToRightWithFade,
                                                  duration: const Duration(
                                                      milliseconds: 450));
                                            },
                                            child: const UtilisContainors(
                                              text: "Gas\nBills",
                                              image: "assets/images/gas.png",
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              backgroundColor: Colors
                                  .white, // Customize background color if needed
                            );
                          },
                          child: const UtilisContainors(
                            text: "Utility\nBills",
                            image: "assets/images/bill.png",
                          ),
                        ),
                        const UtilisContainors(
                          text: "Mobile\nTopUps",
                          image: "assets/images/mobile.png",
                        ),
                        const UtilisContainors(
                          text: "Insurance\n",
                          image: "assets/images/insurance.png",
                        )
                      ],
                    ),

                    20.heightBox,
                    "Your Transactions"
                        .text
                        .size(15)
                        .color(const Color.fromARGB(255, 87, 87, 87))
                        .bold
                        .make(),
                    10.heightBox,
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
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
                                Text(
                                  "See how much money you sent\nand how much you received",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 9),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => AllTransactions(),
                                  transition: Transition.leftToRightWithFade,
                                  duration: const Duration(milliseconds: 450));
                            },
                            child: Padding(
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
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]))),
        ],
      ),
    );
  }
}

class UtilisContainors extends StatelessWidget {
  const UtilisContainors({
    required this.image,
    required this.text,
    super.key,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        5.heightBox,
        Text(
          text,
          textAlign: TextAlign.center, // Align the text in the center
          style: const TextStyle(
            fontSize: 13, // Adjust the font size as needed
            height:
                1.2, // Set lineSpacing to 1.0 or less to decrease the distance between lines
          ),
        )
      ],
    );
  }
}
