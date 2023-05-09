import 'package:abac_challenge/constants.dart';
import 'package:flutter/material.dart';

/// This method is used to build a card
///
/// The card is used to display information about a spaceship
Card buildCard(var title, var subtitle, var cardImageUrl) {
  var heading = title;
  var subheading = subtitle;
  var cardImage = NetworkImage(cardImageUrl);
  var supportingText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
  return Card(
      color: kSecondaryColor,
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              heading,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            subtitle: Text(subheading),
          ),
          Image(
            image: cardImage,
            fit: BoxFit.fill,
            height: kCardImageHeight,
            width: kCardImageWidth,
            alignment: Alignment.center,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              supportingText,
              style: TextStyle(color: Colors.white),
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text(
                  'DIAGNOSE',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {/* ... */},
              )
            ],
          )
        ],
      ));
}
