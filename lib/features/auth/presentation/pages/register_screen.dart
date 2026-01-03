import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/core/utils/size_config.dart';
import 'package:registration/features/auth/presentation/pages/home_screen.dart';
import 'package:registration/features/auth/presentation/pages/login_screen.dart';
import 'package:registration/features/auth/presentation/provider/auth_provider.dart';
import 'package:registration/features/auth/presentation/widgets/custom_button.dart';
import 'package:registration/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:registration/shared/common_widgets/custom_snackbar.dart';
import 'package:registration/shared/common_widgets/custom_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          if (provider.signupError.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              customSnackbar(context, provider.signupError);
              provider.clearMessages();
            });
          }

          if (provider.signupSuccess.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              customSnackbar(context, provider.signupSuccess);
              provider.clearMessages();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(uid: provider.signupResponse["uid"]),
                ),
                (route) => false,
              );
            });
          }
          return Center(
            child: SingleChildScrollView(
              child: Padding(
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
                        text: "SignUp",
                        fontSize: sizeHelper.getTextSize(32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: sizeHelper.getWidgetHeight(40)),

                    customTextField(label: "Name", controller: _nameController),

                    SizedBox(height: sizeHelper.getWidgetHeight(20)),

                    customTextField(
                      label: "Email",
                      controller: _emailController,
                    ),
                    SizedBox(height: sizeHelper.getWidgetHeight(20)),

                    customTextField(
                      label: "Password",
                      controller: _passwordController,
                    ),
                    SizedBox(height: sizeHelper.getWidgetHeight(20)),

                    customTextField(
                      label: "Confirm password",
                      controller: _confirmPasswordController,
                    ),

                    SizedBox(height: sizeHelper.getWidgetHeight(30)),

                    customButton(
                      title: "Register",
                      loading: provider.signupLoading,
                      ontap: provider.signupLoading
                          ? () {}
                          : () {
                              final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              );

                              if (_emailController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                customSnackbar(context, "Please enter email");
                              } else if (!emailRegex.hasMatch(
                                _emailController.text.trim(),
                              )) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                customSnackbar(
                                  context,
                                  "Please enter a valid email",
                                );
                              } else if (_passwordController.text
                                  .trim()
                                  .isEmpty) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                customSnackbar(
                                  context,
                                  "Please enter password",
                                );
                              } else if (_confirmPasswordController.text
                                  .trim()
                                  .isEmpty) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                customSnackbar(
                                  context,
                                  "Please confirm password",
                                );
                              } else if (_passwordController.text.trim() !=
                                  _confirmPasswordController.text.trim()) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                customSnackbar(
                                  context,
                                  "Passwords do not match",
                                );
                              } else {
                                provider.signup(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  name: _nameController.text.trim(),
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
                          text: "Already have an account? ",
                          fontWeight: FontWeight.w400,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          ),
                          child: CustomText(
                            fontSize: sizeHelper.getTextSize(14),
                            text: "Login",
                            textColor: Colors.blue,
                            fontWeight: FontWeight.w600,
                           ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
