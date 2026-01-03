import 'package:flutter/material.dart';
import 'package:registration/core/utils/size_config.dart';
import 'package:registration/shared/common_widgets/custom_text.dart';

Future<dynamic> customDialog(
  BuildContext context, {
  required String heading,
  required String subHeading,
  required VoidCallback onCancelTap,
  required VoidCallback onConfirmTap,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: CustomText(
        fontSize: sizeHelper.getTextSize(17),
        text: heading,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.fade,
      ),
      content: CustomText(
        fontSize: sizeHelper.getTextSize(15),
        text: subHeading,
        textColor: Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
      actions: [
        TextButton(
          onPressed: onCancelTap,
          child: CustomText(
            fontSize: sizeHelper.getTextSize(14),
            text: 'Cancel',
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed:onConfirmTap,
          child: CustomText(
            fontSize: sizeHelper.getTextSize(14),
            text: 'Confirm',
            textColor: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
