import 'package:flutter/material.dart';

class AppSizes {
  static late double w;
  static late double h;
  static late bool isSmall;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    w = size.width;
    h = size.height;
    isSmall = h < 700;
  }

  // Padding
  static double get hp => w * 0.06;
  static double get vp => h * 0.03;

  // Spacing
  static double get spaceXL => h * 0.05;
  static double get spaceL => h * 0.04;
  static double get spaceM => h * 0.025;
  static double get spaceS => h * 0.015;

  // Sizes
  static double get title => isSmall ? 18 : 22;
  static double get buttonPadding => isSmall ? 14 : 16;
  static double get avatarRadius => isSmall ? 18 : 22;
}
