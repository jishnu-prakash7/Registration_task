import 'package:flutter/material.dart';

class SizeHelper {
  double kHeight;
  double kWidth;
  TextScaler? kTextScaler;

  SizeHelper({
    required this.kHeight,
    required this.kWidth,
    required this.kTextScaler,
  });

  double getWidgetHeight(double height) {
    double variableHeightValue = 812 / height;
    return kHeight / variableHeightValue;
  }

  double getWidgetWidth(double width) {
    double variableWidthValue = 375 / width;
    return kWidth / variableWidthValue;
  }

  double getTextSize(double fontSize) {
    return kTextScaler!.scale(fontSize);
  }
}
