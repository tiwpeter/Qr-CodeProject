import 'package:flutter/material.dart';

const cardBackgroundColor = Color(0xFF21222D);
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFFFFFFF);
const backgroundColor = Color(0xFF15131C);
const selectionColor = Color(0xFF88B2AC);

// Define the gradient color
const gradientColors = [
  Color(0xFF007AF5), // Starting color
  Color(0xFFE6F1FE), // Ending color
];

LinearGradient gradient = LinearGradient(
  colors: gradientColors,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
