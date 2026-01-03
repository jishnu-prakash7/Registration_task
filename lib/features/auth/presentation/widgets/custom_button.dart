import 'package:flutter/material.dart';
import 'package:registration/core/utils/size_config.dart';
import 'package:registration/shared/common_widgets/custom_text.dart';

SizedBox customButton({
  required String title,
  required VoidCallback ontap,
  bool loading = false,
}) {
  return SizedBox(
    width: sizeHelper.kWidth,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizeHelper.getWidgetWidth(13)),
        ),
      ),
      onPressed: ontap,
      child: loading == true
          ? const SizedBox( 
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : CustomText(
              fontSize: sizeHelper.getTextSize(16),
              text: title,
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
    ),
  );
}
