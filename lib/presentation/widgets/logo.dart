import 'package:flutter/material.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/core/configs/theme/app_colors.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.logo,
          height: 75,
        ),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [textColor, AppColors.primary],
            tileMode: TileMode.clamp,
          ).createShader(bounds),
          child: const Text(
            'Quickcar',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              fontFamily: 'Satoshi',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
