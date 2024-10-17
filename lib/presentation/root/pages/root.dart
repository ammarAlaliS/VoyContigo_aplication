// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickcar_aplication/presentation/root/pages/appbar/pages/app_bar.dart';
import 'package:quickcar_aplication/presentation/root/pages/buttom_navigator_bar/buttom_navigator_bar.dart';
import 'package:quickcar_aplication/presentation/screen/pages/profile/profile_page.dart';
import 'package:quickcar_aplication/presentation/screen/pages/market/market_page.dart';
import 'package:quickcar_aplication/presentation/screen/pages/message/message_page.dart';
import 'package:quickcar_aplication/presentation/screen/pages/blog/blog_page.dart';
import 'package:quickcar_aplication/presentation/screen/pages/home/home_page.dart';

const Color darkBackgroundColor = Color.fromARGB(255, 10, 10, 10);
const Color lightBackgroundColor = Color.fromARGB(255, 255, 255, 255);

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}
class _RootPageState extends State<RootPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? Color.fromARGB(255, 5, 14, 26) : Color(0xFFF9F9F9),
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDarkMode ? const Color.fromARGB(255, 5, 14, 26) : Colors.white,
      systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    ));

    final List<Widget> pages = [
      HomePage(),
      ProfilePage(),
      MarketplacePage(),
      BlogPage(),
      MessagePage(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBarPage(),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: pages,
        ),
        bottomNavigationBar: ButtomNavigatorBarPage(
          currentIndex: _currentIndex,
          pageController: _pageController,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          isDarkMode: isDarkMode,
        ),
      ),
    );
  }
}
