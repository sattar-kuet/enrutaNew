import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/screen/bottomnavigation/bottomController.dart';
import 'package:enruta/screen/homePage.dart';
import 'package:enruta/screen/myAccount/myaccount.dart';
import 'package:enruta/screen/myFavorite/myFavorite.dart';
import 'package:enruta/screen/orerder/allorder.dart';
import 'package:enruta/screen/searchResult/searchController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// @immutable
class BottomNavigation extends StatelessWidget {
  int _currentIndex = 0;
  // void onTabTappeds(BuildContext context) {
  //   if (_currentIndex == 0) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomePage()),
  //       (Route<dynamic> route) => false,
  //     );
  //   } else if (_currentIndex == 1) {
  //     print("one");
  //   } else if (_currentIndex == 2) {
  //     print("two");
  //   } else if (_currentIndex == 3) {
  //     print("three");
  //   }
  // }

  final search = Get.put(SearchController());

  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    int currentScrreen = 0;
    final bottomController = Get.put(BottomController());

    void onTabTapped(int index) {
      print(index);
      if (index == 0) {
        // if (currentScrreen != 0) {
        //   currentScrreen = index;
        //   Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => HomePage()),
        //     (Route<dynamic> route) => false,
        //   );
        // }
        if (bottomController.curentPage.value == 0) {
          print(currentScrreen);
          bottomController.curentPage.value = 1;
          Get.offAll(HomePage());
        }
      } else if (index == 1) {
        print("one");
        Get.to(MyFavorite());
      } else if (index == 2) {
        // if (currentScrreen != index) {
        //   currentScrreen = index;
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => MyOrder()),
        //   (Route<dynamic> route) => true,
        // );
        Get.to(AllOrder());
        // Get.showSnackbar(goHomebottomfield(context));
        // }
        print("two");
      } else if (index == 3) {
        print("three");
        Get.to(MyAccount());
      } else if (index == 4) {
        print("four");
        Scaffold.of(context).openDrawer();
        // Get.to(GetReviewPage());
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        // selectedItemColor: Color(Helper.getHexToInt("#6F6F6F")),
        unselectedItemColor: Color(Helper.getHexToInt("#929292")),

        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: onTabTapped, // new

        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: Color(Helper.getHexToInt("#929292")),
            ),
            label: text('home'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/heartq.svg",
                height: 22,
                width: 22,
                color: Color(Helper.getHexToInt("#929292"))),
            label: text('Favourite'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/list.svg",
                color: Color(Helper.getHexToInt("#929292"))),
            label: text('order'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/user.svg",
              color: Color(Helper.getHexToInt("#929292")),
            ),
            label: text('account'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/menu.svg",
              color: Color(Helper.getHexToInt("#929292")),
            ),
            label: text('menu'),
          ),
        ],
      ),
    );
  }

  Widget goHomebottomfield(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomePage()),
            //   (Route<dynamic> route) => false,
            // );
          },
          child: Container(
            height: 50,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                Color(Helper.getHexToInt("#11C7A1")),
                // Colors.green[600],
                Color(Helper.getHexToInt("#11E4A1"))
              ]),
              // color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
                child: Text(
              text('go_to_home_page'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'TTCommonsm',
              ),
            )),
          ),
        ),
      ],
    );
  }
}
