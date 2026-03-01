import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_x/get.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:i_cash/core/intern/money_format.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/handle_order_menu_bloc/handle_order_menu_bloc.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/order_menu_bloc.dart';
import 'package:i_cash/features/order_menu/presentation/bloc/tax_bloc/tax_bloc.dart';

class OrderMenuPage extends StatefulWidget {
  const OrderMenuPage({super.key, required this.userLoginEntities});

  final UserLoginEntities userLoginEntities;

  @override
  State<OrderMenuPage> createState() => _OrderMenuPageState();
}

class _OrderMenuPageState extends State<OrderMenuPage> {
  final TextEditingController searchC = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  var subTotal;
  var totalTaxAmount;
  var grandTotal;

  @override
  void initState() {
    super.initState();

    context.read<OrderMenuBloc>().add(GetMenuMakananOrderMenuEvent());
    context.read<TaxBloc>().add(GetTaxEvent());
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
                // PERBAIKAN: Menambahkan ScrollView agar tidak overflow jika item banyak
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ORDER",
                          style: AppTheme.lightTheme.textTheme.headlineLarge,
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<HandleOrderMenuBloc>().add(
                              ClearOrderMenuDataEvent(),
                            );
                          },
                          child: const Text(
                            'Bersihkan',
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "# 20268595",
                      style: AppTheme.lightTheme.textTheme.headlineSmall!
                          .copyWith(color: AppColors.textLight),
                    ),
                    const Divider(color: AppColors.divider),
                    rowText(
                      title: "Tanggal / Jam",
                      value:
                          "${DateTime.now().day.toString().padLeft(2, '0')}/"
                          "${DateTime.now().month.toString().padLeft(2, '0')}/"
                          "${DateTime.now().year} "
                          "${DateTime.now().hour.toString().padLeft(2, '0')}:"
                          "${DateTime.now().minute.toString().padLeft(2, '0')}",
                    ),
                    const Divider(color: AppColors.divider),

                    // Bagian List Item yang bisa di-scroll
                    Expanded(
                      child: SingleChildScrollView(
                        child: BlocBuilder<HandleOrderMenuBloc, HandleOrderMenuState>(
                          builder: (context, state) {
                            if (state is SuccessAddOrderMenuState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Makanan",
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  if (state.menuMakananData.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: state.menuMakananData.length,
                                      itemBuilder: (context, index) {
                                        final data =
                                            state.menuMakananData[index];
                                        // WIDGET ROW ITEM MAKANAN
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  data.menu.name.toString(),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("${data.quantity}x"),
                                                    IconButton(
                                                      constraints:
                                                          const BoxConstraints(),
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                              HandleOrderMenuBloc
                                                            >()
                                                            .add(
                                                              DropOrderMenuDataEvent(
                                                                menu: data.menu,
                                                              ),
                                                            );
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,

                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,

                                                  children: [
                                                    Text(
                                                      MoneyFormat.formatRupiahFromString(
                                                        data.menu.sellPrice
                                                            .toString(),
                                                      ),

                                                      style: TextStyle(
                                                        fontWeight:
                                                            data.quantity == 1
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                      ),
                                                    ),

                                                    SizedBox(height: 5),

                                                    data.quantity > 1
                                                        ? Text(
                                                            MoneyFormat.formatRupiahFromString(
                                                              (data.quantity *
                                                                      int.parse(
                                                                        data
                                                                            .menu
                                                                            .sellPrice
                                                                            .toString(),
                                                                      ))
                                                                  .toString(),
                                                            ),

                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  else
                                    const Text(
                                      "Tambahkan Makanan +",
                                      style: TextStyle(color: Colors.grey),
                                    ),

                                  const SizedBox(height: 15),
                                  Text(
                                    "Minuman",
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  if (state.menuMinumanData.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: state.menuMinumanData.length,
                                      itemBuilder: (context, index) {
                                        final data =
                                            state.menuMinumanData[index];
                                        // WIDGET ROW ITEM MINUMAN
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  data.menu.name.toString(),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("${data.quantity}x"),
                                                    IconButton(
                                                      constraints:
                                                          const BoxConstraints(),
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                              HandleOrderMenuBloc
                                                            >()
                                                            .add(
                                                              DropOrderMenuDataEvent(
                                                                menu: data.menu,
                                                              ),
                                                            );
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,

                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,

                                                  children: [
                                                    Text(
                                                      MoneyFormat.formatRupiahFromString(
                                                        data.menu.sellPrice
                                                            .toString(),
                                                      ),

                                                      style: TextStyle(
                                                        fontWeight:
                                                            data.quantity == 1
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                      ),
                                                    ),

                                                    SizedBox(height: 5),

                                                    data.quantity > 1
                                                        ? Text(
                                                            MoneyFormat.formatRupiahFromString(
                                                              (data.quantity *
                                                                      int.parse(
                                                                        data
                                                                            .menu
                                                                            .sellPrice
                                                                            .toString(),
                                                                      ))
                                                                  .toString(),
                                                            ),

                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  else
                                    const Text(
                                      "Tambahkan Minuman +",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                ],
                              );
                            }
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/add.png',
                                    height: 80,
                                  ),
                                  const Text(
                                    "Tambahkan menu yang akan dipesan",
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // SEKSI TOTAL DAN PAJAK (Stay di bawah)
                    const Divider(thickness: 1),
                    BlocBuilder<TaxBloc, TaxState>(
                      builder: (context, taxState) {
                        if (taxState is SuccessGetTaxState) {
                          return BlocBuilder<
                            HandleOrderMenuBloc,
                            HandleOrderMenuState
                          >(
                            builder: (context, orderState) {
                              subTotal = context
                                  .read<HandleOrderMenuBloc>()
                                  .totalHarga;

                              final activeTaxes = taxState.taxData
                                  .where((e) => e.activeTax == '1')
                                  .toList();
                              final totalTaxPercent = activeTaxes.fold<double>(
                                0,
                                (sum, tax) =>
                                    sum + double.parse(tax.percentTax ?? "0"),
                              );
                              totalTaxAmount = subTotal * totalTaxPercent / 100;
                              grandTotal = subTotal + totalTaxAmount;

                              return Column(
                                children: [
                                  ...activeTaxes.map(
                                    (tax) => Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: rowText(
                                        title: tax.nameTax.toString(),
                                        value: "${tax.percentTax}%",
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  rowText(
                                    title: "Subtotal",
                                    value: MoneyFormat.formatRupiahFromString(
                                      subTotal.toStringAsFixed(0),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  rowText(
                                    title:
                                        "Pajak (${totalTaxPercent.toStringAsFixed(0)}%)",
                                    value: MoneyFormat.formatRupiahFromString(
                                      totalTaxAmount.toStringAsFixed(0),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1.5,
                                    color: Colors.black54,
                                  ),
                                  rowText(
                                    title: "Total",

                                    value: MoneyFormat.formatRupiahFromString(
                                      grandTotal.toStringAsFixed(0),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
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

                                  return _menuList(data, context);
                                }

                                /// SUCCESS MINUMAN
                                if (state is SuccessOrderMenuMinumanState) {
                                  final data = state.menuData;

                                  if (data.isEmpty) {
                                    return const Center(
                                      child: Text("Menu minuman kosong"),
                                    );
                                  }

                                  return _menuList(data, context);
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
                        child: const Text("Order"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("12312"),
                      ),
                      BlocConsumer<HandleOrderMenuBloc, HandleOrderMenuState>(
                        bloc: context.read<HandleOrderMenuBloc>(),
                        listener: (context, state) {
                          if (state is SuccessAddOrderMenuTakeAwayState) {
                            Get.showSnackbar(
                              GetSnackBar(
                                snackPosition: SnackPosition.top,
                                maxWidth: 500,
                                borderRadius: 15,
                                backgroundColor: AppColors.completed,
                                messageText: Text(
                                  state.message,
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: AppColors.cardBackground,
                                      ),
                                ),
                                animationDuration: const Duration(
                                  milliseconds: 500,
                                ),
                                duration: const Duration(seconds: 4),
                              ),
                            );
                            context.read<HandleOrderMenuBloc>().add(
                              ClearOrderMenuDataEvent(),
                            );
                          } else if (state is FailedAddOrderMenuTakeAwayState) {
                            Get.showSnackbar(
                              GetSnackBar(
                                snackPosition: SnackPosition.top,
                                maxWidth: 500,
                                borderRadius: 15,
                                backgroundColor: AppColors.cardBackground,
                                messageText: Text(
                                  state.message,
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: Colors.red),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<HandleOrderMenuBloc>().add(
                                TakeAwayOrderMenuEvent(
                                  serviceAndTax: totalTaxAmount.toString(),
                                  userData: widget.userLoginEntities,
                                  noTaxPrice: subTotal.toString(),
                                  totalPrice: grandTotal.toString(),
                                ),
                              );
                            },
                            child: const Text("Take Away"),
                          );
                        },
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
Widget _menuList(List<MenuEntities> data, BuildContext context) {
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
              onPressed: () {
                context.read<HandleOrderMenuBloc>().add(
                  AddOrderMenuDataEvent(menu: item),
                );
              },
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


// double get totalHarga {
//   return _cartMakanan.fold(0, (sum, item) {
//     return sum +
//         (double.parse(item.menu.sellPrice ?? "0") *
//             item.quantity);
//   });
// }