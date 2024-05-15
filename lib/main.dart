import 'package:ewallet/Screens/pages/SignIn.dart';
import 'package:ewallet/Screens/pages/SignUp.dart';
import 'package:ewallet/Screens/pages/Splash.dart';
import 'package:ewallet/ThemeApp.dart';
import 'package:ewallet/controllers/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      ChangeNotifierProvider(create: (_) => Providers(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(false, context),
      home: Splash(),
      routes: {
        "SignUp": (context) => const SignUp(),
        "SignIn": (context) => SignIn(),
      },
    );
  }
}
