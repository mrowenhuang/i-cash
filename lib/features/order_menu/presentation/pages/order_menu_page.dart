import 'package:flutter/material.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';

class OrderMenuPage extends StatelessWidget {
  const OrderMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Card(
              color: AppColors.cardBackground,
              child: Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order",
                      style: AppTheme.lightTheme.textTheme.headlineLarge,
                    ),
                    Text(
                      "# 20268595",
                      style: AppTheme.lightTheme.textTheme.headlineSmall!
                          .copyWith(color: AppColors.textLight),
                    ),
                    Divider(color: AppColors.divider),
                    rowText(title: "Jam orderan", value: "20:08:40"),
                    Divider(color: AppColors.divider),
                    rowText(title: "Total", value: "100000"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Card(
                    color: AppColors.cardBackground,
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Menu",
                            style: AppTheme.lightTheme.textTheme.headlineLarge,
                          ),
                          Divider(color: AppColors.divider),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text("12312")),
                      ElevatedButton(onPressed: () {}, child: Text("12312")),
                      ElevatedButton(onPressed: () {}, child: Text("12312")),
                    ],
                  ),
                ),
                // Card(
                //   color: AppColors.cardBackground,
                //   child: Padding(
                //     padding: EdgeInsetsGeometry.all(16),
                //     child: Column(
                //       children: [
                //         Text(
                //           "Order",
                //           style: AppTheme.lightTheme.textTheme.headlineLarge,
                //         ),
                //         Divider(color: AppColors.divider),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget rowText({required String title, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: AppTheme.lightTheme.textTheme.bodyLarge),
      Text(value, style: AppTheme.lightTheme.textTheme.bodyLarge),
    ],
  );
}
