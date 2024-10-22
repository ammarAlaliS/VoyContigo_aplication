import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickcar_aplication/presentation/root/pages/appbar/pages/app_bar.dart';
import 'package:quickcar_aplication/presentation/root/pages/buttom_navigator_bar/buttom_navigator_bar.dart';
import 'package:quickcar_aplication/presentation/screen/pages/profile/profile_page.dart';
import 'package:quickcar_aplication/presentation/screen/pages/market/market_page.dart';
import 'package:quickcar_aplication/presentation/screen/pages/message/message_page.dart';
import 'package:quickcar_aplication/presentation/screen/pages/blog/blog_page.dart';
import 'package:quickcar_aplication/presentation/screen/pages/home/home_page.dart';



class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

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

    _setSystemUIOverlayStyle(isDarkMode);

    final List<Widget> pages = [
      const HomePage(),
      ProfilePage(),
      MarketplacePage(),
      BlogPage(),
      MessagePage(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: const AppBarPage(),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          children: pages,
        ),
        bottomNavigationBar: BottomNavigatorBarPage(
          currentIndex: _currentIndex,
          pageController: _pageController,
          onTap: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          isDarkMode: isDarkMode,
        ),
      ),
    );
  }

  void _setSystemUIOverlayStyle(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 219, 255, 238),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: isDarkMode 
          ? const Color.fromARGB(255, 255, 255, 255) 
          : Colors.black,
      systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    ));
  }
}
