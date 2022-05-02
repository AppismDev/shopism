import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/favorites_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Views/Home/View/home_page_view.dart';
import 'package:shopism/Views/Profile/profile_page.dart';

import '../../../Controllers/cart_page_controller.dart';

class TabPageView extends StatefulWidget {
  const TabPageView({Key? key}) : super(key: key);

  @override
  State<TabPageView> createState() => _TabPageViewState();
}

class _TabPageViewState extends State<TabPageView> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static const List<Widget> _widgets = [
    HomePageView(),
    ProfilePage(),
    // ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    Get.put(FavoritesController(), tag: GetxKeys.FAVORITES_CONTROLLER.toString());
    Get.put(CartPageController(), tag: GetxKeys.CART_PAGE_CONTROLLER.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        destinations: [
          NavigationDestination(selectedIcon: Icon(Icons.home), icon: Icon(Icons.home_outlined), label: "Home"),
          NavigationDestination(selectedIcon: Icon(Icons.person), icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //
      //   onTap: ((value) => setState(() {
      //     _selectedIndex = value;
      //   })),
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "Home"
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: "Profile",
      //     )
      //   ],
      // ),
      body: Center(
        child: _widgets.elementAt(_selectedIndex),
      ),
      // body: DefaultTabController(
      //   length: _widgets.length,
      //   child: Stack(
      //     children: [
      //       TabBarView(children: _widgets, physics: NeverScrollableScrollPhysics()),
      //       Align(
      //         alignment: Alignment.bottomCenter,
      //         child: Card(
      //           elevation: 16,
      //           clipBehavior: Clip.antiAlias,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(12),
      //           ),
      //           margin: context.paddingAllLow,
      //           child: TabBar(tabs: [
      //             Tab(
      //               iconMargin: context.paddingOnlyBottomVeryLow,
      //               text: "Home",
      //               icon: Icon(
      //                 Icons.home,
      //                 size: 28,
      //               ),
      //             ),
      //             Tab(
      //               iconMargin: context.paddingOnlyBottomVeryLow,
      //               text: "Profile",
      //               icon: Icon(
      //                 Icons.person,
      //                 size: 28,
      //               ),
      //             ),
      //             Tab(
      //               iconMargin: context.paddingOnlyBottomVeryLow,
      //               text: "Settings",
      //               icon: Icon(
      //                 Icons.settings,
      //                 size: 26,
      //               ),
      //             )
      //           ]),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
