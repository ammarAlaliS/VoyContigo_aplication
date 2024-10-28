import 'package:flutter/material.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/presentation/screen/pages/home/common/home_component_card.dart';
import 'package:quickcar_aplication/presentation/screen/pages/home/components/home_component_user_card.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HomeComponentUserCard(),
        SizedBox(height: 5),
        HomeComponentCard(
          title: "Ofertas del día",
          description: "Todo depende de tu estado de ánimo.",
          carouselItems: [
            {'image': AppImages.food, 'title': 'Restaurantes'},
            {'image': AppImages.drinks, 'title': 'Bares'},
            {'image': AppImages.hotels, 'title': 'Viajes'},
          ],
          gradientColors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 254, 245, 162),
          ],
          imagePath: AppImages.oferta,
        ),
        SizedBox(height: 5),
        HomeComponentCard(
          title: "Próximos Eventos",
          description: "No te pierdas lo que viene.",
          carouselItems: [
            {'image': AppImages.concert, 'title': 'Conciertos'},
            {'image': AppImages.art, 'title': 'Arte'},
            {'image': AppImages.theater_play, 'title': 'Teatro'},
          ],
          gradientColors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 254, 162, 162),
          ],
          imagePath: AppImages.event,
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
