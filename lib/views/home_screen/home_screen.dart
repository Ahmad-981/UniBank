import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/controller/home_controller.dart';
// import 'package:taco/views/home_screen/truck_info/truck_screen.dart';
import 'package:unibank/widgets_common/custom_text_field.dart';
// import 'package:taco/widgets_common/map_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              children: [
                //(context.screenHeight * 0.07).heightBox,
                Row(
                  children: [
                    5.widthBox,
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.heightBox,
                          Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    "Hi Ahmad"
                                        .text
                                        .size(15)
                                        .color(whiteColor)
                                        .bold
                                        .make(),
                                    5.widthBox,
                                    Image.asset(
                                      "assets/images/handImg.PNG",
                                      height: 25,
                                      width: 25,
                                    )
                                  ]),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Balance:"
                                  .text
                                  .size(20)
                                  .color(whiteColor)
                                  .semiBold
                                  .make(),
                              5.heightBox,
                              "\$200"
                                  .text
                                  .size(27)
                                  .color(whiteColor)
                                  .bold
                                  .fontWeight(FontWeight.w900)
                                  .make(),
                              20.heightBox,
                            ],
                          ).box.margin(EdgeInsets.only(left: 10)).make()
                        ],
                      ),
                    )),
                  ],
                ).box.padding(EdgeInsets.symmetric(horizontal: 10)).make(),
                20.heightBox,
                20.heightBox,
                Column(children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                      4,
                      (index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/images/home2.PNG",
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                          ).box.clip(Clip.antiAlias).roundedFull.make(),
                          "Mexican".text.size(12).white.semiBold.makeCentered()
                        ],
                      )
                          .box
                          .color(redColor)
                          .shadowLg
                          .size(120, 55)
                          .roundedLg
                          .margin(const EdgeInsets.all(4))
                          .padding(EdgeInsets.symmetric(horizontal: 3))
                          //.margin(const EdgeInsets.symmetric(horizontal: 3))
                          .make(),
                    )),
                  ),
                  //5.heightBox,
                  GestureDetector(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 10,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 250,
                                crossAxisCount: 1),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/home1.PNG",
                                width: context.screenWidth,
                                height: 150,
                                fit: BoxFit.fill,
                              ).box.rounded.shadow.clip(Clip.antiAlias).make(),
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "Tasty Tacos"
                                      .text
                                      .size(15)
                                      .color(Color.fromARGB(255, 87, 87, 87))
                                      .semiBold
                                      .make(),
                                  "(4.5)"
                                      .text
                                      .color(redColor)
                                      .bold
                                      .size(14)
                                      .make()
                                ],
                              ),
                              5.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "Mexican"
                                      .text
                                      .size(11)
                                      .color(Colors.grey)
                                      .semiBold
                                      .make(),
                                  10.widthBox,
                                  "(Starting in 10 min)"
                                      .text
                                      .size(10)
                                      .color(Color.fromARGB(255, 87, 87, 87))
                                      .semiBold
                                      .make(),
                                  "2.5 km away"
                                      .text
                                      .size(11)
                                      .color(Colors.grey)
                                      .semiBold
                                      .make(),
                                ],
                              )
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .shadowSm
                              .padding(const EdgeInsets.all(8))
                              .make()
                              .onTap(() {
                            //Get.to(() => const TruckScreen());
                          });
                        }),
                  ),
                ])
              ],
            )),
      ),
    );
  }
}
