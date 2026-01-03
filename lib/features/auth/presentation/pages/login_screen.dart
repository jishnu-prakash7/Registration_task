import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/core/utils/size_config.dart';
import 'package:registration/features/auth/presentation/pages/home_screen.dart';
import 'package:registration/features/auth/presentation/provider/auth_provider.dart';
import 'package:registration/features/auth/presentation/widgets/custom_button.dart';
import 'package:registration/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:registration/shared/common_widgets/custom_snackbar.dart';
import 'package:registration/shared/common_widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          if (provider.loginError.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).clearSnackBars();

              customSnackbar(context, provider.loginError);

              provider.clearMessages();
            });
          }

          if (provider.loginSuccess.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).clearSnackBars();

              customSnackbar(context, provider.loginSuccess);

              provider.clearMessages();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(uid: provider.loginResponse["uid"]),
                ),
                (route) => false,
              );
            });
          }

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: sizeHelper.getWidgetWidth(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Login",
                      fontSize: sizeHelper.getTextSize(32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: sizeHelper.getWidgetHeight(40)),

                  customTextField(label: "Email", controller: _emailController),

                  SizedBox(height: sizeHelper.getWidgetHeight(20)),

                  customTextField(
                    label: "Password",
                    controller: _passwordController,
                  ),

                  SizedBox(height: sizeHelper.getWidgetHeight(30)),

                  customButton(
                    title: "Login",
                    loading: provider.loginLoading,
                    ontap: provider.loginLoading
                        ? () {}
                        : () {
                            if (_emailController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).clearSnackBars();

                              customSnackbar(context, "Please enter email");
                            } else if (_passwordController.text
                                .trim()
                                .isEmpty) {
                              ScaffoldMessenger.of(context).clearSnackBars();

                              customSnackbar(context, "Please enter password");
                            } else {
                              provider.login(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          },
                  ),
                  SizedBox(height: sizeHelper.getWidgetHeight(30)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        fontSize: sizeHelper.getTextSize(14),
                        text: "New User? ",
                        fontWeight: FontWeight.w400,
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () => Navigator.pop(context),
                        child: CustomText(
                          fontSize: sizeHelper.getTextSize(14),
                          text: "Create Account",
                          textColor: Colors.blue,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
