import 'package:flutter/material.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:i_cash/core/intern/export_db.dart';
import 'package:i_cash/core/widget/sidebar_button.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/dashboard/presentation/pages/dashboard_view_page.dart';
import 'package:i_cash/features/menu/presentation/pages/menu_page.dart';
import 'package:i_cash/features/order/presentation/pages/order_page.dart';
import 'package:i_cash/features/setting/presentation/pages/setting_page.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key, required this.userloginData});

  final UserLoginEntities userloginData;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int activePage = 1;

  List<dynamic> get page => [
    DashboardViewPage(),
    MenuPage(),
    OrderPage(),
    SettingPage(userLoginData: widget.userloginData),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.cardBackground,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/icash.png', height: 130),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        activePage = 0;
                      });
                    },
                    child: sideBarButton(
                      iconPath: 'assets/icons/dashboard.png',
                      text: "Dashboard",
                      isActive: true,
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        activePage = 1;
                      });
                    },
                    child: sideBarButton(
                      iconPath: 'assets/icons/sign-in.png',
                      text: "Menu",
                      isActive: false,
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  sideBarButton(
                    iconPath: 'assets/icons/sign-in.png',
                    text: "Orders",
                    isActive: false,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  SizedBox(height: 15),
                  sideBarButton(
                    iconPath: 'assets/icons/sign-in.png',
                    text: "Table",
                    isActive: false,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      // await exportDB();
                      activePage = 3;
                      setState(() {});
                    },
                    child: sideBarButton(
                      iconPath: 'assets/icons/sign-in.png',
                      text: "Setting",
                      isActive: false,
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 9, child: page[activePage]),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
}
