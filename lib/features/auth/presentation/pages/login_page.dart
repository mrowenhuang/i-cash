import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_x/get.dart';
import 'package:i_cash/common/theme/app_color.dart';
import 'package:i_cash/common/theme/app_theme.dart';
import 'package:i_cash/core/intern/password.dart';
import 'package:i_cash/core/widget/sidebar_button.dart';
import 'package:i_cash/core/widget/warning_bottom_sheet.dart';
import 'package:i_cash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:i_cash/features/dashboard/presentation/pages/dashboard_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailC = TextEditingController(
    text: 'user123@icash.com',
  );
  final TextEditingController passC = TextEditingController(text: "Icash123!");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.cardBackground,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/icash.png', height: 130),
                  sideBarButton(
                    iconPath: 'assets/icons/sign-in.png',
                    text: "Login",
                    isActive: true,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Center(
              child: SizedBox(
                height: 300,
                width: 400,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Masukan Akun",
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(color: AppColors.primaryDark),
                        ),
                        Divider(),
                        SizedBox(height: 15),
                        TextField(
                          controller: emailC,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                            hintText: "Username",
                          ),
                        ),
                        SizedBox(height: 15),
                        TextField(
                          controller: passC,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.primary,
                            ),
                            hintText: "Password",
                          ),
                        ),
                        SizedBox(height: 15),
                        BlocConsumer<AuthBloc, AuthState>(
                          bloc: context.read<AuthBloc>(),
                          listener: (context, state) {
                            if (state is FailedAuthLoginState) {
                              showWarningSheet(state.message);
                            } else if (state is SuccessAuthLoginState) {
                              Get.offAll(() => DashboardPage());
                            }
                          },

                          builder: (context, state) {
                            if (state is LoadingAuthLoginState) {
                              return Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  var data = hashPassword(passC.text);
                                  print(data);
                                  context.read<AuthBloc>().add(
                                    LoginClickAuthEvent(
                                      email: emailC.text.trim(),
                                      password: passC.text.trim(),
                                    ),
                                  );
                                },
                                label: Text("Masuk"),
                                icon: Icon(Icons.login),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
