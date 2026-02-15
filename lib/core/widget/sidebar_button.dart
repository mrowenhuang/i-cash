import 'package:flutter/material.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';

Widget sideBarButton({
  required String text,
  required TextStyle? style,
  required String iconPath,
  required bool isActive,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),

    decoration: BoxDecoration(
      color: isActive ? AppColors.accent : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Image.asset(iconPath, color: AppColors.primaryDark, height: 24),
        SizedBox(width: 15),
        Text(text, style: style),
      ],
    ),
  );
}
