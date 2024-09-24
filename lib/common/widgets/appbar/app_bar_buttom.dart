// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppBarButtom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarButtom({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.3), 
                shape: BoxShape.circle),
            child: Icon(
              color: isDarkMode ? Colors.black : Colors.white,
              Icons.arrow_back_ios_new,
              size: 15,
            ),
          )),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}