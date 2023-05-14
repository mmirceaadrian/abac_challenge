import 'package:flutter/material.dart';

/// This widget is used to show a medium card
class MediumCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String image;
  final String bottomText;
  final String? rating;
  final Function() onTap;
  final bool isSelected;

  const MediumCard(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.image,
      required this.bottomText,
      this.rating,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Card(
          elevation: 4,
          color: isSelected ? Colors.green.shade300 : Colors.white,
          shadowColor: Colors.grey[500],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //colum with data
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // row with title and subtitle and rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // column with title and subtitle
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              subtitle != null ? subtitle! : '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // row with bottom text
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Text(
                        bottomText,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // row with rating and reviews
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  rating != null
                      ? Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        )
                      : Container(),
                  Text(
                    rating != null ? rating! : '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
              //image
              SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )),
    );
  }
}
