import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/features/auth/presentation/pages/register_screen.dart';
import 'package:registration/features/auth/presentation/provider/auth_provider.dart';
import 'package:registration/core/utils/size_config.dart';
import 'package:registration/features/auth/presentation/widgets/custom_button.dart';
import 'package:registration/shared/common_widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().getUserDetails(uid: widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          if (provider.getUserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.getUserError.isNotEmpty) {
            return Center(
              child: CustomText(
                fontSize: sizeHelper.getTextSize(16),
                text: provider.getUserError,
                textColor: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          }

          final user = provider.getUserResponse;

          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizeHelper.getWidgetWidth(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    fontSize: sizeHelper.getTextSize(16),
                    text: "Hello ${user['name'] ?? ''}",
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: sizeHelper.getWidgetHeight(10)),
                  customButton(
                    title: "Signout",
                    ontap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                        (route) => false,
                      );
                    },
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
