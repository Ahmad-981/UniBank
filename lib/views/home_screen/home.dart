import 'package:unibank/consts/consts.dart';
// import 'package:unibank/views/home_screen/truck_info/popular/popular_screen.dart';
// import 'package:taco/views/more_screen/more_screen.dart';
// import 'package:taco/views/checkout/checkout_scree.dart';
// import 'package:taco/views/featured/featured_screen.dart';
// import 'package:taco/views/find_screen/find_screen.dart';
import 'package:unibank/views/home_screen/home_screen.dart';
//import 'package:taco/views/orders_screen/orders_screen.dart';
// import 'package:taco/widgets_common/custom_text_field.dart';
import 'package:unibank/controller/home_controller.dart';
// import 'package:emart_app/views/cart_screen/cart_screen.dart';
// import 'package:emart_app/views/categories_screen/categories_screen.dart';
// import 'package:emart_app/views/home_screen/home_screen.dart';
// import 'package:emart_app/views/profile_screen/profile_screen.dart';

// import 'package:taco/widgets_common/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:unibank/views/profile/profile_screen.dart';

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
          Icons.search_outlined,
          color: redColor,
        ),
        label: "Find",
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.list_alt_outlined,
          color: redColor,
        ),
        label: "Orders",
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
      const HomeScreen(),
      const HomeScreen(),
      const HomeScreen(),
      const HomeScreen(),
      // const FindScreen(),
      // const OrdersScreen(),

      //const FeaturedScreen(),

      //const MoreScreen(),
      // const PopularScreen(),
      // const ProfileScreen(),
    ];

    //Main
    return WillPopScope(
      onWillPop: () async {
        // showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (context) {
        //       return getExitButtonDialog(context);
        //     });

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
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
