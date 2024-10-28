import 'package:flutter/material.dart';

import 'package:quickcar_aplication/presentation/screen/pages/home/components/custom_scroll.dart';
import 'package:quickcar_aplication/presentation/screen/pages/home/home_content.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: ScrollableContent(
        child: HomeContent(),
      ),
    );
  }
}