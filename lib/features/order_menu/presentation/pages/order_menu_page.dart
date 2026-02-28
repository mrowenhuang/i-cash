import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:i_cash/core/intern/money_format.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/order_menu_bloc.dart';
import 'package:i_cash/features/setting/presentation/bloc/setting_bloc.dart';

class OrderMenuPage extends StatefulWidget {
  const OrderMenuPage({super.key});

  @override
  State<OrderMenuPage> createState() => _OrderMenuPageState();
}

class _OrderMenuPageState extends State<OrderMenuPage> {
  final TextEditingController searchC = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<OrderMenuBloc>().add(GetMenuMakananOrderMenuEvent());
  }

  @override
  void dispose() {
    searchC.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          /// ================= LEFT PANEL =================
          Expanded(
            child: Card(
              color: AppColors.cardBackground,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ORDER",
                      style: AppTheme.lightTheme.textTheme.headlineLarge,
                    ),
                    Text(
                      "# 20268595",
                      style: AppTheme.lightTheme.textTheme.headlineSmall!
                          .copyWith(color: AppColors.textLight),
                    ),
                    Divider(color: AppColors.divider),

                    rowText(
                      title: "Tanggal / Jam",
                      value: DateTime.now().toString(),
                    ),

                    Divider(color: AppColors.divider),

                    Text(
                      "Makanan",
                      style: AppTheme.lightTheme.textTheme.headlineSmall,
                    ),
                    Text(
                      "Minuman",
                      style: AppTheme.lightTheme.textTheme.headlineSmall,
                    ),

                    const Spacer(),

                    rowText(title: "Total", value: "100000"),
                  ],
                ),
              ),
            ),
          ),

          /// ================= RIGHT PANEL =================
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Card(
                    color: AppColors.cardBackground,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// HEADER + SEARCH
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Menu",
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .headlineLarge,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: searchC,
                                  focusNode: searchFocus,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),

                                    /// ⭐ SOLUSI UTAMA
                                    suffixIconConstraints: const BoxConstraints(
                                      minHeight: 20,
                                      minWidth: 20,
                                    ),

                                    suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: Colors.red,
                                      constraints: const BoxConstraints(),
                                      iconSize: 18,
                                      onPressed: () {
                                        searchC.clear();
                                        context.read<OrderMenuBloc>().add(
                                          SearchMenuOrderMenuEvent(key: ''),
                                        );
                                        searchFocus.requestFocus();
                                      },
                                      icon: const Icon(Icons.clear),
                                    ),

                                    hintText: "Cari...",
                                    isDense: true, // ⭐ penting
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    context.read<OrderMenuBloc>().add(
                                      SearchMenuOrderMenuEvent(
                                        key: searchC.text.trim(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                          Divider(color: AppColors.divider),

                          /// TAB
                          DefaultTabController(
                            length: 2,
                            child: TabBar(
                              tabAlignment: TabAlignment.start,
                              padding: EdgeInsets.zero,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                color: const Color(0xFFFFC542),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              dividerColor: Colors.transparent,
                              labelColor: const Color(0xFF1B7F79),
                              unselectedLabelColor: Colors.grey,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              tabs: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Tab(text: "Makanan"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Tab(text: "Minuman"),
                                ),
                              ],
                              onTap: (value) {
                                context.read<OrderMenuBloc>().add(
                                  ChangeTabOrderMenuEvent(index: value),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// LIST MENU
                          Expanded(
                            child: BlocBuilder<OrderMenuBloc, OrderMenuState>(
                              builder: (context, state) {
                                /// LOADING
                                if (state is LoadingOrderMenuMakananState ||
                                    state is LoadingOrderMenuMinumanState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                /// SUCCESS MAKANAN
                                if (state is SuccessOrderMenuMakananState) {
                                  final data = state.menuData;

                                  if (data.isEmpty) {
                                    return const Center(
                                      child: Text("Menu makanan kosong"),
                                    );
                                  }

                                  return _menuList(data);
                                }

                                /// SUCCESS MINUMAN
                                if (state is SuccessOrderMenuMinumanState) {
                                  final data = state.menuData;

                                  if (data.isEmpty) {
                                    return const Center(
                                      child: Text("Menu minuman kosong"),
                                    );
                                  }

                                  return _menuList(data);
                                }

                                /// ERROR
                                if (state is FailedOrderMenuMakananState ||
                                    state is FailedOrderMenuMinumanState) {
                                  return const Center(
                                    child: Text("Gagal load menu"),
                                  );
                                }

                                return const SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// BOTTOM BUTTONS
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("12312"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("12312"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("12312"),
                      ),
                    ],
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

/// ================= LIST TILE BUILDER =================
Widget _menuList(List data) {
  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (_, i) {
      final item = data[i];

      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: Material(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(item.name ?? "-"),
            subtitle: Text(
              MoneyFormat.formatRupiahFromString(item.sellPrice.toString()),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_circle, color: AppColors.primary),
            ),
          ),
        ),
      );
    },
  );
}

/// ================= ROW TEXT =================
Widget rowText({required String title, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: AppTheme.lightTheme.textTheme.bodyLarge),
      Text(value, style: AppTheme.lightTheme.textTheme.bodyLarge),
    ],
  );
}
