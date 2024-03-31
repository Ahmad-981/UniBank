import 'package:unibank/consts/consts.dart';
import 'package:unibank/views/feature_screen/feature_screen.dart';
import 'package:unibank/views/home_screen/home_screen.dart';
import 'package:unibank/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibank/views/more_screen/more_screen.dart';
import 'package:unibank/widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    var navbarItem = [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home_outlined,
          color: redColor,
        ),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.star_border_outlined,
          color: redColor,
        ),
        label: "Featured",
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.more_horiz_outlined,
          color: redColor,
        ),
        label: "More",
      ),
    ];

    //List 2
    var navBody = [
      const HomeScreen(),
      const FeatureScreen(),
      const MoreScreen(),
    ];

    //Main
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return getExitButtonDialog(context);
            });

        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                  child:
                      navBody.elementAt(homeController.currenItemIndex.value)),
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: homeController.currenItemIndex.value,
            items: navbarItem,
            selectedItemColor: redColor,
            backgroundColor: whiteColor,
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              homeController.currenItemIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
