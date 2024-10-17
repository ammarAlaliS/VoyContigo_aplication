import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';

class ButtomNavigatorBarPage extends StatefulWidget {
  final int currentIndex;
  final PageController pageController;
  final Function(int) onTap;
  final bool isDarkMode;

  const ButtomNavigatorBarPage({
    super.key,
    required this.currentIndex,
    required this.pageController,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  State<ButtomNavigatorBarPage> createState() => _ButtomNavigatorBarPageState();
}

class _ButtomNavigatorBarPageState extends State<ButtomNavigatorBarPage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = widget.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? const Color.fromARGB(255, 205, 204, 204).withOpacity(0.09)
                : Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        selectedItemColor: isDarkMode ? const Color.fromARGB(255, 234, 234, 234) : const Color.fromARGB(255, 24, 24, 35),
        unselectedItemColor: isDarkMode ? const Color.fromARGB(255, 255, 255, 255) : Colors.black54,
        onTap: (index) {
          widget.onTap(index);
          widget.pageController.jumpToPage(index);
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? Color.fromARGB(255, 5, 14, 26) : Colors.white,
            icon: SvgPicture.asset(
              AppVectors.home,
              color: widget.currentIndex == 0 ? const Color.fromARGB(255, 6, 143, 255) : Colors.grey, // Color activo o inactivo
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
           backgroundColor: isDarkMode ? const Color.fromARGB(255, 5, 14, 26) : Colors.white,
            icon: SvgPicture.asset(
              AppVectors.user,
               color: widget.currentIndex == 1 ? const Color.fromARGB(255, 6, 143, 255) : Colors.grey, 
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
           backgroundColor: isDarkMode ? const Color.fromARGB(255, 5, 14, 26) : Colors.white,
            icon: SvgPicture.asset(
              AppVectors.shop,
                color: widget.currentIndex == 2 ? const Color.fromARGB(255, 6, 143, 255) : Colors.grey, 
            ),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? const Color.fromARGB(255, 5, 14, 26) : Colors.white,
            icon: SvgPicture.asset(
              AppVectors.article,
                color: widget.currentIndex == 3 ? const Color.fromARGB(255, 6, 143, 255) : Colors.grey, 
            ),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? const Color.fromARGB(255, 5, 14, 26) : Colors.white,
            icon: SvgPicture.asset(
              AppVectors.message,
                color: widget.currentIndex == 4 ? const Color.fromARGB(255, 6, 143, 255) : Colors.grey, 
            ),
            label: 'Messages',
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          color: isDarkMode ? const Color.fromARGB(255, 0, 0, 0) : Colors.black54,
        ),
      ),
    );
  }
}
