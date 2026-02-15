import 'dart:math';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:i_cash/core/intern/money_format.dart';
import 'package:i_cash/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:intl/intl.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    context.read<MenuBloc>().add(GetMenuDataEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
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
          SizedBox(height: 15),
          BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              if (state is LoadingMenuState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SuccessMenuState) {
                final tabs = [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Tab(text: "Semua"),
                  ),
                  ...state.groupedMenu.keys.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Tab(text: e),
                    ),
                  ),
                ];

                return DefaultTabController(
                  length: tabs.length,
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: const Color(0xFFFFC542),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    labelColor: const Color(0xFF1B7F79),
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: tabs,
                    onTap: (value) {
                      context.read<MenuBloc>().add(
                        ChangeTabMenuEvent(
                          groupedMenu: state.groupedMenu,
                          index: value,
                        ),
                      );
                    },
                  ),
                );
              }

              return const SizedBox();
            },
          ),

          SizedBox(height: 15),

          BlocBuilder<MenuBloc, MenuState>(
            bloc: context.read<MenuBloc>(),
            builder: (context, state) {
              if (state is LoadingMenuState) {
                return Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is FailedMenuState) {
                return Expanded(child: Center(child: Text(state.message)));
              } else if (state is SuccessMenuState) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: state.menuData.length,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: 0,
                      bottom: 60,
                    ), // ← ini hapus gap atas
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: .75,
                    ),

                    itemBuilder: (context, index) {
                      final dataMenu = state.menuData[index];

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
                              Text(
                                dataMenu.name.toString(),
                                style:
                                    AppTheme.lightTheme.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                MoneyFormat.formatRupiahFromString(
                                  dataMenu.sellPrice.toString(),
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    elevation: 0,
                                    color: AppColors.accentDark.withOpacity(.5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        top: 4,
                                        bottom: 4,
                                      ),
                                      child: Text(
                                        dataMenu.groupName.toString(),
                                      ),
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: .8, // ubah ukuran (1 = default)
                                    child: CupertinoSwitch(
                                      value: dataMenu.status == "1"
                                          ? true
                                          : false,
                                      activeColor:
                                          AppColors.accent, // warna aktif
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [Text("Status")],
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: Text("Data menu kosong coba sinkron ulang"),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
