import 'package:flutter/material.dart';

class SpaceshipMiniCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? image;

  const SpaceshipMiniCard({Key? key, this.title, this.subtitle, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shadowColor: Colors.grey[500],
      child: Container(
        constraints: BoxConstraints(
            minHeight: 50, maxHeight: 100, minWidth: 200, maxWidth: 300),
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                image!,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Servisare",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
