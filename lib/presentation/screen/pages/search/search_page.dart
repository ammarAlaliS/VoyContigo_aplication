// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/screen/pages/search/components/appbar/search_appbar_component.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: SearchAppbarComponent(),
        ),
        body: Stack(
          children: [
            // Imagen de fondo
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/quickarapp.appspot.com/o/promotions%2Fbg.jpg?alt=media&token=4b1005aa-f087-4cc0-8894-ed36d16209fb',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: SvgPicture.asset(
                      AppVectors.texture,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: isDarkMode
                          ? const Color.fromARGB(255, 14, 14, 14)
                          : const Color.fromARGB(255, 243, 243, 243),
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
                top: 300,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color.fromARGB(255, 5, 14, 26)
                            : Colors.white,
                        border: Border.all(
                          color: Colors.orange.shade100.withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: isDarkMode
                                ? Colors.black54
                                : Colors.grey.withOpacity(0.3),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Divider(
                            color: Colors.transparent,
                          ),
                          _buildListTile(
                              '4Q52+PQX, Managua, Nicaragua', Icons.location_on,
                              () {
                            // Acción al tocar
                          }),
                          const Divider(),
                          _buildListTile('A', Icons.place, () {
                            // Acción al tocar
                          }),
                          const Divider(),
                          _buildListTile('Hora de viaje', Icons.access_time,
                              () {
                            // Acción al tocar
                          }),
                          const Divider(),
                          _buildListTile('Asientos totales 0', Icons.event_seat,
                              () {
                            // Acción al tocar
                          }),
                          const Divider(
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          
                          color: isDarkMode
                              ? Colors.orange.shade100.withOpacity(0.3)
                              : Colors.cyan,
                          border: Border.all(
                            color: Colors.orange.shade100.withOpacity(0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(top: 5),
                      ),
                    ),
                    BasicButton(
                        onPressed: () {}, title: 'Buscar viaje', height: 40)
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Text(title),
        ],
      ),
    ),
  );
}
