import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_x/get.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:i_cash/core/intern/account_and_token.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:i_cash/features/setting/domain/usecases/sync_menu.dart';
import 'package:i_cash/features/setting/presentation/bloc/setting_bloc.dart';
import 'package:i_cash/features/setting/presentation/bloc/tax_bloc/tax_bloc.dart';
import 'package:intl/intl.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key, required this.userLoginData});

  final UserLoginEntities userLoginData;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameTaxc = TextEditingController();
    final TextEditingController taxPercentC = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// CONTENT LIST
            Expanded(
              child: ListView(
                children: [
                  /// SYNC MENU
                  BlocBuilder<SettingBloc, SettingState>(
                    bloc: context.read<SettingBloc>(),
                    builder: (context, state) {
                      return listTileSync(
                        showResponse: state is SuccessSyncMenuDataSettingState,
                        trailing: state is LoadingSyncMenuDataSettingState
                            ? const CircularProgressIndicator()
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
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  /// LAPORAN
                  listTileSync(
                    color: Colors.green,
                    responseMessage: '',
                    showResponse: false,
                    trailing: Icon(
                      Icons.sync,
                      color: AppColors.primaryDark,
                      size: 30,
                    ),
                    title: "Kirim Laporan Penjualan",
                    subtitle:
                        "*Lakukan pengiriman laporan penjualan ke server pada saat tutup kasir",
                  ),

                  const SizedBox(height: 12),

                  /// TAX
                  BlocConsumer<TaxBloc, TaxState>(
                    bloc: context.read<TaxBloc>(),
                    listener: (context, state) {
                      if (state is SuccessAddTaxDataSettingState) {
                        Get.showSnackbar(
                          GetSnackBar(
                            snackPosition: SnackPosition.top,
                            maxWidth: 500,
                            borderRadius: 15,
                            backgroundColor: AppColors.cardBackground,
                            messageText: Text(
                              state.message,
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(color: AppColors.ready),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else if (state is FailedAddTaxDataSettingState) {
                        Get.showSnackbar(
                          GetSnackBar(
                            snackPosition: SnackPosition.top,
                            maxWidth: 500,
                            borderRadius: 15,
                            backgroundColor: AppColors.cardBackground,
                            messageText: Text(
                              state.message,
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(color: Colors.red),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else if (state is FailedGetTaxDataSettingState) {
                        Get.showSnackbar(
                          GetSnackBar(
                            snackPosition: SnackPosition.top,
                            maxWidth: 500,
                            borderRadius: 15,
                            backgroundColor: AppColors.cardBackground,
                            messageText: Text(
                              state.message,
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(color: Colors.red),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return listTileSync(
                        color: Colors.green,
                        responseMessage: '',
                        showResponse: false,
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.attach_money_rounded,
                            size: 30,
                          ),
                          color: AppColors.primaryDark,
                          onPressed: () async {
                            context.read<TaxBloc>().add(
                              GetTaxDataSettingEvent(),
                            );

                            await Get.bottomSheet(
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        controller: nameTaxc,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.abc,
                                            color: AppColors.primary,
                                          ),
                                          hintText: "Nama",
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      TextField(
                                        controller: taxPercentC,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.percent,
                                            color: AppColors.primary,
                                          ),
                                          hintText: "Persen",
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: AppColors.primary,
                                          ),
                                          onPressed: () {
                                            context.read<TaxBloc>().add(
                                              AddTaxDataSettingEvent(
                                                nameTaxc.text.trim(),
                                                taxPercentC.text.trim(),
                                              ),
                                            );
                                          },
                                          label: Text(
                                            "Tambah",
                                            style: AppTheme
                                                .lightTheme
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color: AppColors.primary,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Pajak / Service yang sudah ada",
                                        style: AppTheme
                                            .lightTheme
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      const SizedBox(height: 15),

                                      if (state
                                          is LoadingGetTaxDataSettingState)
                                        const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      else if (state
                                          is SuccessGetTaxDataSettingState)
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: (state).taxEntites.length,
                                          itemBuilder: (_, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 10,
                                              ),
                                              child: Material(
                                                elevation: 2,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: ListTile(
                                                  title: const Text("name"),
                                                  subtitle: const Text(
                                                    "percent",
                                                  ),
                                                  tileColor:
                                                      AppColors.cardBackground,
                                                  trailing: Transform.scale(
                                                    scale: .8,
                                                    child: CupertinoSwitch(
                                                      value: true,
                                                      activeColor:
                                                          AppColors.accent,
                                                      onChanged: (_) {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      else
                                        const Center(
                                          child: Text("Tidak ada data"),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              backgroundColor: AppColors.cardBackground,
                              enableDrag: true,
                            );
                          },
                        ),
                        title: "Tambah Pajak / Service Penjualan",
                        subtitle:
                            "*Lakukan penyesuaian jika transaksi penjualan terkena pajak / service",
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  listTileSync(
                    color: Colors.green,
                    responseMessage: '',
                    showResponse: false,
                    trailing: Icon(
                      Icons.table_bar_rounded,
                      color: AppColors.primaryDark,
                      size: 30,
                    ),
                    title: "Tambah Jumlah Meja",
                    subtitle: "*Lakukan penyesuaian untuk jumlah meja tersedia",
                  ),

                  const SizedBox(height: 12),

                  listTileSync(
                    color: Colors.green,
                    responseMessage: '',
                    showResponse: false,
                    trailing: Icon(
                      Icons.copy_outlined,
                      color: AppColors.primaryDark,
                      size: 30,
                    ),
                    title: "Backup Data",
                    subtitle: "*Backup data lokal ke penyimpanan eksternal",
                  ),

                  const SizedBox(height: 12),

                  listTileSync(
                    color: Colors.green,
                    responseMessage: '',
                    showResponse: false,
                    trailing: Icon(
                      Icons.generating_tokens_rounded,
                      color: AppColors.primaryDark,
                      size: 30,
                    ),
                    title: "Perpanjang Masa Aktif",
                    subtitle: "*Perpanjang masa aktif aplikasi",
                  ),

                  const SizedBox(height: 16),

                  /// CARD MASA AKTIF
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "Masa Aktif Berakhir Pada",
                            style: AppTheme.lightTheme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
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

                  const SizedBox(height: 20),

                  /// VERSION
                  Center(
                    child: Text(
                      "Versi Aplikasi 1.0.0",
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
  required bool showResponse,
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
        showResponse
            ? Text(
                responseMessage,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              )
            : SizedBox(),
      ],
    ),
    // trailing: IconButton(
    //   onPressed: onpressed,
    //   icon: Icon(icon, color: AppColors.primaryDark, size: 30),
    // ),
    trailing: trailing,
  );
}
