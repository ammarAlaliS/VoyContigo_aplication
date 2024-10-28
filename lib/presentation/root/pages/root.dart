import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/core/configs/bloc/scroll_cubit.dart';
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

class _RootPageState extends State<RootPage> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final double _defaultAppBarHeight = 100.0;
  final double _reducedAppBarHeight = 50.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Escuchar los cambios de estado del cubo
    context.read<ScrollControllerCubit>().stream.listen((scrollState) {
      if (scrollState.position > 0 && _controller.status != AnimationStatus.forward) {
        _controller.forward();
      } else if (scrollState.position <= 0 && _controller.status != AnimationStatus.reverse) {
        _controller.reverse();
      }
    });

    _animation = Tween<double>(begin: _defaultAppBarHeight, end: _reducedAppBarHeight).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final List<Widget> pages = [
      HomePage(),
      ProfilePage(),
      MarketplacePage(),
      BlogPage(),
      MessagePage(),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 255, 238),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_animation.value),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                height: _animation.value,
                child: const AppBarPage(),
              );
            },
          ),
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
}

