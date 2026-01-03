import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:registration/core/dependencies/dependencies.dart';
import 'package:registration/core/utils/size_config.dart';
import 'package:registration/core/utils/size_helper.dart';
import 'package:registration/features/auth/presentation/pages/register_screen.dart';
import 'package:registration/features/auth/presentation/provider/auth_provider.dart';
import 'package:registration/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: (BuildContext context, Widget? child) {
        final data = MediaQuery.of(
          context,
        ).copyWith(textScaler: const TextScaler.linear(1.0));
        sizeHelper = SizeHelper(
          kHeight: data.size.height,
          kWidth: data.size.width,
          kTextScaler: data.textScaler,
        );
        return MediaQuery(data: data, child: child!);
      },
      home: RegisterScreen(),
    );
  }
}
