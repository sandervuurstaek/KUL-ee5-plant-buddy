import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardDecoration extends BoxDecoration{
  double radius;
  CardDecoration(this.radius):super(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.25),
        spreadRadius: 0.25,
        blurRadius: 20,
      ),
    ],
    borderRadius: BorderRadius.circular(radius),
    color: Colors.white,
  );
}