import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:i_cash/common/theme/app_theme.dart';

Future showWarningSheet(String message) {
  return Get.bottomSheet(_WarningSheet(message: message));
}

class _WarningSheet extends StatelessWidget {
  final String message;
  const _WarningSheet({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Image.asset("assets/icons/warning.png", height: 120),
          Spacer(),
          Text(
            "Peringatan",
            style: AppTheme.lightTheme.textTheme.displayMedium,
          ),
          Spacer(),
          Text(message, style: AppTheme.lightTheme.textTheme.bodyLarge),
          Spacer(),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
            ),
          ),
        ],
      ),
    );
  }
}
