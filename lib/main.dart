import 'package:flutter/material.dart';
import 'package:flutter_application/pages/create_profile_page.dart';
import 'package:flutter_application/pages/home_page.dart';
import 'package:flutter_application/utils/colors.dart';
import 'package:hive_flutter/adapters.dart';

import 'helpers/hive_box_helper.dart';
import 'models/history_model.dart';
import 'models/user_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  HiveBoxHelper.openUserBox();
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
      home: const HomePage(),
    );
  }
}
