import 'package:flutter/material.dart';

class FavoritesWidget extends StatefulWidget {
  const FavoritesWidget({super.key});

  @override
  State<FavoritesWidget> createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Title",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'RobotoFlex',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "form",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'RobotoFlex',
                fontWeight: FontWeight.w200,
              ),
            ),
            Text(
              "text",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'RobotoSerif',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "Button",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'RobotoFlex',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
