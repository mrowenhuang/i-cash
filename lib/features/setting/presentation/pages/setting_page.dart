import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:i_cash/core/intern/account_and_token.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:i_cash/features/setting/domain/usecases/sync_menu.dart';
import 'package:i_cash/features/setting/presentation/bloc/setting_bloc.dart';
import 'package:intl/intl.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key, required this.userLoginData});

  final UserLoginEntities userLoginData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<SettingBloc, SettingState>(
          bloc: context.read<SettingBloc>(),
          builder: (context, state) {
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     // print(userLoginData);
                //     var response = AccountAndToken().isStillValid(
                //       userLoginData.startDate.toString(),
                //       int.parse(userLoginData.activeAccount.toString()),
                //     );
                //     print(response);
                //   },
                //   child: Text("12213"),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Setting",
                        style: AppTheme.lightTheme.textTheme.displaySmall,
                      ),
                      Text(
                        DateFormat(
                          "EEEE, d MMMM yyyy",
                          "id_ID",
                        ).format(DateTime.now()),
                        style: AppTheme.lightTheme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                listTileSync(
                  // icon: Icons.sync,
                  trailing: state is LoadingSyncMenuDataSettingState
                      ? CircularProgressIndicator()
                      : IconButton(
                          onPressed: () {
                            context.read<SettingBloc>().add(
                              SyncMenuDataSettingEvent(userLoginData),
                            );
                          },
                          icon: Icon(
                            Icons.sync,
                            color: AppColors.primaryDark,
                            size: 30,
                          ),
                        ),
                  responseMessage: state is FailedSyncMenuDataSettingState
                      ? state.message
                      : state is SuccessSyncMenuDataSettingState
                      ? state.message
                      : "",
                  color: state is FailedSyncMenuDataSettingState
                      ? Colors.red
                      : AppColors.ready,
                  title: "Sinkronisasi Menu",
                  subtitle:
                      "*Lakukan sinkronisasi untuk memperbarui data menu dari server",
                  // onpressed: () {
                  //   context.read<SettingBloc>().add(
                  //     SyncMenuDataSettingEvent(userLoginData),
                  //   );
                  // },
                ),
                SizedBox(height: 12),
                // listTileSync(
                //   icon: Icons.sync,
                //   title: "Kirim Laporan Penjualan",
                //   subtitle:
                //       "*Lakukan pengiriman laporan penjualan ke server pada saat tutup kasir",
                //   onpressed: () {},
                // ),

                // SizedBox(height: 12),
                // listTileSync(
                //   icon: Icons.copy,
                //   title: "Backup Data",
                //   subtitle:
                //       "*Lakukan backup data lokal ke penyimpanan eksternal untuk menjaga keamanan data",
                //   onpressed: () {},
                // ),

                // SizedBox(height: 12),
                // listTileSync(
                //   icon: Icons.generating_tokens_rounded,
                //   title: "Perpanjang Masa Aktif",
                //   subtitle:
                //       "*Lakukan perpanjangan masa aktif aplikasi untuk memastikan kelancaran operasional",
                //   onpressed: () {},
                // ),
                Card(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Masa Aktif Berakhir Pada",
                          style: AppTheme.lightTheme.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          AccountAndToken().getExpiredDate(
                            userLoginData.startDate.toString(),
                            int.parse(userLoginData.activeAccount.toString()),
                          ),
                          style: AppTheme.lightTheme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "Versi Aplikasi 1.0.0",
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget listTileSync({
  required String title,
  required String subtitle,
  required String responseMessage,
  required Color color,
  // required VoidCallback onpressed,
  // required IconData icon,
  required Widget trailing,
}) {
  return ListTile(
    tileColor: AppColors.cardBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    title: Text(
      title,
      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subtitle, style: AppTheme.lightTheme.textTheme.bodySmall),
        Text(
          responseMessage,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    // trailing: IconButton(
    //   onPressed: onpressed,
    //   icon: Icon(icon, color: AppColors.primaryDark, size: 30),
    // ),
    trailing: trailing,
  );
}
