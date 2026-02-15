import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:intl/intl.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Menu", style: AppTheme.lightTheme.textTheme.displaySmall),
                Text(
                  DateFormat(
                    "EEEE, d MMMM yyyy",
                    "id_ID",
                  ).format(DateTime.now()),
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          CustomSlidingSegmentedControl<int>(
            initialValue: 2,
            children: {
              1: Text('News daily portal'),
              2: Text('Map'),
              3: Text('Paper'),
            },
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            thumbDecoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInToLinear,
            onValueChanged: (v) {
              print(v);
            },
          ),

          Expanded(
            child: GridView.builder(
              itemCount: 25,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: .8,
              ),

              itemBuilder: (context, index) {
                return Card(
                  color: AppColors.cardBackground,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.blueGrey,
                          height: 100,
                          // margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Nama Makanan"),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Jenis"), Text("Rp 50000")],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status"),
                            Transform.scale(
                              scale: .8, // ubah ukuran (1 = default)
                              child: CupertinoSwitch(
                                value: true,
                                activeColor: AppColors.accent, // warna aktif
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
