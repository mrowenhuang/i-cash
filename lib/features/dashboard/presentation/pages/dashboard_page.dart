import 'package:flutter/material.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:i_cash/core/widget/sidebar_button.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/dashboard/presentation/pages/dashboard_view_page.dart';
import 'package:i_cash/features/menu/presentation/pages/menu_page.dart';
import 'package:i_cash/features/order/presentation/pages/order_page.dart';
import 'package:i_cash/features/order_menu/presentation/pages/order_menu_page.dart';
import 'package:i_cash/features/setting/presentation/pages/setting_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.userloginData});

  final UserLoginEntities userloginData;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int activePage = 0;

  List<Widget> get page => [
    const DashboardViewPage(),
    const MenuPage(),
    const OrderPage(),
    SettingPage(userLoginData: widget.userloginData),
    const OrderMenuPage(),
  ];

  void changePage(int index) {
    setState(() => activePage = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          /// SIDEBAR
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.cardBackground,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Image.asset('assets/icons/icash.png', height: 130),

                  /// SCROLL AREA
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _menuButton(
                            index: 0,
                            icon: 'assets/icons/dashboard.png',
                            title: "Dashboard",
                          ),
                          _space(),
                          _menuButton(
                            index: 1,
                            icon: 'assets/icons/sign-in.png',
                            title: "Menu",
                          ),
                          _space(),
                          _menuButton(
                            index: 2,
                            icon: 'assets/icons/sign-in.png',
                            title: "Orders",
                          ),
                          _space(),
                          _menuButton(
                            index: 4,
                            icon: 'assets/icons/sign-in.png',
                            title: "Table",
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// SETTING BUTTON (FIXED BOTTOM)
                  _menuButton(
                    index: 3,
                    icon: 'assets/icons/sign-in.png',
                    title: "Setting",
                  ),
                ],
              ),
            ),
          ),

          /// PAGE CONTENT
          Expanded(flex: 9, child: page[activePage]),
        ],
      ),

      /// FLOAT BUTTON
      floatingActionButton: activePage == 4
          ? null
          : FloatingActionButton.extended(
              onPressed: () => changePage(4),
              icon: const Icon(Icons.add),
              label: Text(
                "Tambah Orderan",
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  Widget _menuButton({
    required int index,
    required String icon,
    required String title,
  }) {
    final bool active = activePage == index;

    return GestureDetector(
      onTap: () => changePage(index),
      child: sideBarButton(
        iconPath: icon,
        text: title,
        isActive: active,
        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: active ? AppColors.primary : AppColors.primaryDark,
        ),
      ),
    );
  }

  Widget _space() => const SizedBox(height: 15);
}
