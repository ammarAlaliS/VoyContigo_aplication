import 'package:flutter/material.dart';

class SearchAppbarComponent extends StatefulWidget {
  const SearchAppbarComponent({super.key});

  @override
  State<SearchAppbarComponent> createState() => _SearchAppbarComponentState();
}

class _SearchAppbarComponentState extends State<SearchAppbarComponent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          color: isDarkMode ? Color.fromARGB(255, 5, 14, 26) : Colors.white,
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.1),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey.withOpacity(0.5)
                        : Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    color: isDarkMode ? Colors.black : Colors.white,
                    Icons.arrow_back_ios_new,
                    size: 15,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: RichText(
                  textAlign: TextAlign.left, // Align text to the left
                  text: TextSpan(
                    text: 'Encuentra y reserva tu próximo viaje\n',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: screenWidth * 0.04, // Font size responsive to screen width
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'con ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.035, 
                        ),
                      ),
                      TextSpan(
                        text: 'QuickCar',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: screenWidth * 0.04,
                           fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: ', miles de opciones te esperan.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
