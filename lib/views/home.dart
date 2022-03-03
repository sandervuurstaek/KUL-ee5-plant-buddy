import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/my_plants.dart';
import 'package:plantbuddy/views/overview.dart';
import 'package:plantbuddy/views/settings.dart';

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
    return AdaptiveNavigationScaffold(
      selectedIndex: _currentPage,
      destinations: const [
        AdaptiveScaffoldDestination(title: "Overview", icon: Icons.today),
        AdaptiveScaffoldDestination(
            title: "My Plants", icon: CommunityMaterialIcons.sprout),
        AdaptiveScaffoldDestination(title: "Settings", icon: Icons.settings),
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
    ;
  }
}
