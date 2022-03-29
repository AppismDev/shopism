import 'package:flutter/material.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Views/Home/View/home_page_view.dart';
import 'package:shopism/Views/Profile/ProfilePage.dart';

class TabPageView extends StatefulWidget {
  const TabPageView({Key? key}) : super(key: key);

  @override
  State<TabPageView> createState() => _TabPageViewState();
}

class _TabPageViewState extends State<TabPageView>
    with SingleTickerProviderStateMixin {
  static const List<Widget> _widgets = [
    HomePageView(),
    ProfilePage(),
    ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _widgets.length,
        child: Stack(
          children: [
            TabBarView(children: _widgets),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                elevation: 16,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: context.paddingAllLow,
                child: TabBar(tabs: [
                  Tab(
                    iconMargin: context.paddingOnlyBottomVeryLow,
                    text: "Home",
                    icon: Icon(
                      Icons.home,
                      size: 28,
                    ),
                  ),
                  Tab(
                    iconMargin: context.paddingOnlyBottomVeryLow,
                    text: "Profile",
                    icon: Icon(
                      Icons.person,
                      size: 28,
                    ),
                  ),
                  Tab(
                    iconMargin: context.paddingOnlyBottomVeryLow,
                    text: "Settings",
                    icon: Icon(
                      Icons.settings,
                      size: 26,
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
