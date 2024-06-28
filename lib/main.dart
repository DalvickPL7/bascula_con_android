import 'package:flutter/material.dart';
import 'package:flutter_application/pages/create_profile_page.dart';
import 'package:flutter_application/widgets/colors.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: MyColors.primary,
          fontFamily: 'Quicksand',
          colorScheme: const ColorScheme.light(primary: MyColors.primary),
          filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ))),
      debugShowCheckedModeBanner: false,
      home: const CreateProfilePage(),
    );
  }
}
