import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';

class BottomNavigatorBarPage extends StatelessWidget {
  final int currentIndex;
  final PageController pageController;
  final Function(int) onTap;
  final bool isDarkMode;

  const BottomNavigatorBarPage({
    Key? key,
    required this.currentIndex,
    required this.pageController,
    required this.onTap,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: isDarkMode 
            ? const Color.fromARGB(255, 234, 234, 234) 
            : const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: isDarkMode 
            ? const Color.fromARGB(255, 255, 255, 255) 
            : Colors.black54,
        onTap: (index) {
          onTap(index);
          pageController.jumpToPage(index);
        },
        items: _buildBottomNavigationBarItems(),
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        backgroundColor: isDarkMode ? const Color.fromARGB(255, 5, 14, 26) : Colors.black,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    const items = [
      {'icon': AppVectors.home, 'label': 'Home'},
      {'icon': AppVectors.user, 'label': 'Profile'},
      {'icon': AppVectors.shop, 'label': 'Marketplace'},
      {'icon': AppVectors.article, 'label': 'Blog'},
      {'icon': AppVectors.message, 'label': 'Messages'},
    ];

    return List.generate(items.length, (index) {
      final item = items[index];
      final isSelected = currentIndex == index;
      final iconColor = isSelected ? const Color.fromARGB(255, 255, 170, 86) : Colors.grey;

      return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          item['icon']!,
          color: iconColor,
        ),
        label: item['label'],
        tooltip: item['label'], // Mejora de accesibilidad
      );
    });
  }
}
