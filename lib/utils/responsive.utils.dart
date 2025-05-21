import 'package:flutter/material.dart';

class ResponsiveUtils {
  static const double kMobileMaxWidth = 600.0;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < kMobileMaxWidth;
  }
}
