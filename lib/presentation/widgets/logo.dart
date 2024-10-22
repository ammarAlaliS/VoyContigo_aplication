import 'package:flutter/material.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.logo,
          height: 250,
        ),
      ],
    );
  }
}
