import 'package:flutter/material.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:intl/intl.dart';

class DashboardViewPage extends StatelessWidget {
  const DashboardViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchC = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now()),
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          topCard(
                            title: "Total Orderan",
                            iconPath: "assets/icons/order_finish.png",
                          ),
                          topCard(
                            title: "Makan ditempat",
                            iconPath: "assets/icons/chair.png",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: longCard(
                    title: "Total Orderan",
                    iconPath: "assets/icons/order_finish.png",
                    controller: searchC,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget topCard({required String title, required String iconPath}) {
  return Expanded(
    child: Card(
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.headlineMedium,
                ),
                Card(
                  elevation: 2,
                  // color: AppColors.inProgress.withOpacity(.5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      iconPath,
                      height: 35,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 15),
            Text("86", style: AppTheme.lightTheme.textTheme.displaySmall),
            SizedBox(height: 15),
            Text(
              "*orderan akan diupdate ketika ada transaksi",
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget longCard({
  required String title,
  required String iconPath,
  required TextEditingController controller,
}) {
  return Card(
    color: AppColors.cardBackground,
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Riwayat Orderan",
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              // prefixIcon: Icon(Icons.person, color: AppColors.primary),
              suffixIcon: Icon(Icons.search, color: AppColors.primary),
              hintText: "Pencarian",
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      tileColor: AppColors.inProgress.withOpacity(.1),
                      title: Text(
                        "No Order $index",
                        style: AppTheme.lightTheme.textTheme.titleLarge,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Tipe Pembayaran :"), Text("cash")],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Nomor Meja :"), Text("5")],
                          ),
                          Text("#1 indomie goreng"),
                          Text("#2 Nasi goreng telur"),
                          Text("#3 Ikan bakar cabe hijau merah"),
                        ],
                      ),
                      
                      trailing: Text("15:06"),
                    ),
                    Divider(color: AppColors.divider,)
                  ],
                );
              },
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Card(
          //       elevation: 2,
          //       // color: AppColors.inProgress.withOpacity(.5),
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Image.asset(
          //           iconPath,
          //           height: 35,
          //           color: AppColors.primary,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15),
          // Text("86", style: AppTheme.lightTheme.textTheme.displaySmall),
          // SizedBox(height: 15),
          // Text(
          //   "*orderan akan diupdate ketika ada transaksi",
          //   style: AppTheme.lightTheme.textTheme.bodySmall,
          // ),
        ],
      ),
    ),
  );
}
