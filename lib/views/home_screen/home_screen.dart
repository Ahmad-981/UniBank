import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/home_controller.dart';
import 'package:unibank/controller/transfer_controller.dart';
import 'package:unibank/views/more_screen/more_screen.dart';
import 'package:unibank/views/transactions/add_transaction.dart';
import 'package:unibank/views/transactions/all_transaction.dart';
import 'package:unibank/views/transactions/bills/electricity.dart';
import 'package:unibank/views/transactions/bills/gas_bills.dart';
import 'package:unibank/views/transactions/bills/water_bills.dart';
import 'package:unibank/views/transactions/insurance/insurance_page.dart';
import 'package:unibank/views/transactions/mobile_topups/packages.dart';
import 'package:unibank/views/transactions/money_transfer.dart';
// import 'package:taco/views/home_screen/truck_info/truck_screen.dart';
import 'package:unibank/widgets_common/functions.dart';
import 'package:timezone/timezone.dart' as tz;

// import 'package:taco/widgets_common/map_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    schedulePeriodicExecution();
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> schedulePeriodicExecution() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool executedToday = prefs.getBool('executedToday') ?? false;
    DateTime now = DateTime.now();
    if (!executedToday) {
      // Call your function here
      await userController.checkAndPrintRecentSubscriptions();

      // Update the flag to indicate execution
      await prefs.setBool('executedToday', true);

      // Schedule the next execution for the next day
      DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
      Duration delay = tomorrow.difference(now);
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0, // Notification ID
        'Periodic Execution', // Notification title
        'Your function executed', // Notification body
        tz.TZDateTime.from(tomorrow, tz.local), // Schedule time
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

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
                                Get.put(HomeController());
                            return Container(
                              padding: const EdgeInsets.all(15),
                              // padding: const EdgeInsets.only(
                              //     left: 10, top: 10, bottom: 20),
                              decoration: const BoxDecoration(
                                  color: redColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      "assets/images/bg1.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      30.heightBox,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              10.widthBox,
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage:
                                                    const AssetImage(
                                                  'assets/images/food2.PNG',
                                                ),
                                                backgroundColor:
                                                    redColor, // Make background transparent
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: redColor,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
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
                                                      .fontFamily(regular)
                                                      .size(12)
                                                      .color(whiteColor)
                                                      .make(),
                                                  10.widthBox,
                                                  controller.currentUser
                                                              .value ==
                                                          null
                                                      ? "Sherlock"
                                                          .text
                                                          .size(14)
                                                          .color(whiteColor)
                                                          //.bold
                                                          .make()
                                                      : controller.currentUser
                                                          .value!.name.text
                                                          .size(14)
                                                          .color(whiteColor)
                                                          .fontFamily(semibold)
                                                          .make(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      30.heightBox,
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child:
                                                "   \$ ${controller.amount!.value}"
                                                    .text
                                                    .size(25)
                                                    .color(whiteColor)
                                                    .fontFamily(semibold)
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
                                      35.heightBox,
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
                                              height: 40,
                                              width: 140,
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
                                                      color: redColor,
                                                      size: 15,
                                                    ),
                                                    5.widthBox,
                                                    const Text(
                                                      "Add Money",
                                                      style: TextStyle(
                                                          color: redColor,
                                                          fontFamily: semibold,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => const MoreScreen());
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 140,
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
                                                      Icons
                                                          .account_circle_outlined,
                                                      color: redColor,
                                                      size: 15,
                                                    ),
                                                    5.widthBox,
                                                    const Text(
                                                      "My Account",
                                                      style: TextStyle(
                                                          color: redColor,
                                                          fontFamily: semibold,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      20.heightBox,
                                    ],
                                  ),
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

                    30.heightBox,
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width,

                                height: 250,
                                // Set width to screen width
                                // Define the content of your bottom sheet here
                                child: Column(
                                  mainAxisSize: MainAxisSize
                                      .min, // Set to min to occupy minimum height
                                  children: [
                                    // Add any widgets you want to display in the bottom sheet
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 80.0, top: 20, right: 20),
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
                                          10.widthBox,
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
                                          10.widthBox,
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
                        InkWell(
                          onTap: () {
                            Get.to(() => MobilePackages(),
                                transition: Transition.leftToRightWithFade,
                                duration: const Duration(milliseconds: 450));
                          },
                          child: const UtilisContainors(
                            text: "Mobile\nTopUps",
                            image: "assets/images/mobile.png",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => Insurance(),
                                transition: Transition.leftToRightWithFade,
                                duration: const Duration(milliseconds: 450));
                          },
                          child: const UtilisContainors(
                            text: "Insurance\n",
                            image: "assets/images/insurance.png",
                          ),
                        ),
                      ],
                    ),
                    35.heightBox,
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
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/bg1.jpg",
                            ),
                            fit: BoxFit.cover),
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
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "See how much money you sent\nand how much you received",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 224, 224, 224),
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: semibold,
                                    fontSize: 13,
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
            borderRadius: BorderRadius.circular(15),
            color: redColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
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
            fontSize: 13,
            fontFamily: regular,
            // Adjust the font size as needed
            height:
                1.2, // Set lineSpacing to 1.0 or less to decrease the distance between lines
          ),
        )
      ],
    );
  }
}
