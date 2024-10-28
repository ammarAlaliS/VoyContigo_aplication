import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeComponentCard extends StatelessWidget {
  final String title;
  final String description;
  final List<Map<String, String>>? carouselItems; // Carrusel opcional
  final List<Color> gradientColors; // Gradiente
  final String imagePath;

  const HomeComponentCard({
    Key? key,
    required this.title,
    required this.description,
    this.carouselItems,
    required this.gradientColors,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: _buildBoxDecoration(gradientColors, isDarkMode),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _buildUserMessage(title, description, isDarkMode, constraints)),
                  Image.asset(
                    imagePath,
                    width: 150,
                    height: 200,
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (carouselItems != null) _buildCarousel(isDarkMode, carouselItems!),
            ],
          );
        },
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(List<Color> gradientColors, bool isDarkMode) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
     
     
    );
  }

  Widget _buildUserMessage(String title, String description, bool isDarkMode, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            width: constraints.maxWidth / 2,
            child: AutoSizeText(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
                letterSpacing: -2,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: constraints.maxWidth / 2,
            child: AutoSizeText(
              description,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                height: 1,
                color: Colors.yellow[900],
                letterSpacing: -2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(bool isDarkMode, List<Map<String, String>> items) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
  colors: isDarkMode
      ? [Colors.white, const Color.fromARGB(255, 0, 174, 255)]
      : [
          const Color.fromARGB(255, 150, 186, 169),
          const Color.fromARGB(255, 3, 20, 27)
        ],
  begin: Alignment.topCenter, // Cambiado a topCenter
  end: Alignment.bottomCenter, // Cambiado a bottomCenter
),
       
      ),
      child: ClipRRect(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CarouselSlider.builder(
                itemCount: items.length,
                itemBuilder: (context, index, realIdx) {
                  return _buildCarouselItem(
                    items[index]['image']!,
                    items[index]['title']!,
                    isDarkMode,
                  );
                },
                options: CarouselOptions(
                  enlargeCenterPage: false,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.3,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Acción al presionar "Ver más"
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: Color.fromARGB(255, 219, 255, 238),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Ver más",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, color: Colors.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath, String title, bool isDarkMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 40),
        AutoSizeText(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.white,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
