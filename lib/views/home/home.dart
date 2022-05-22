import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/myPlants/my_plants.dart';
import 'package:plantbuddy/views/overview/overview.dart';
import 'package:plantbuddy/views/setting/settings.dart';

import '../../model/User.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    print(User().token);
    return AdaptiveNavigationScaffold(
      selectedIndex: _currentPage,
      destinations: const [
        AdaptiveScaffoldDestination(title: "Overview", icon: Icons.home),
        AdaptiveScaffoldDestination(
            title: "My Plants", icon: CommunityMaterialIcons.sprout),
        AdaptiveScaffoldDestination(title: "settings", icon: Icons.settings),
      ],
      onDestinationSelected: (index) {
        _pageController.jumpToPage(
          index,
        );
      },
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: const [
            Overview(),
            MyPlants(),
            Settings(),
          ],
          onPageChanged: (index) {
            setState(() => _currentPage = index);
          },
        ),
      ),
    );

  }
}
