import 'package:hive/hive.dart';

import '../models/user_model.dart';

class HiveBoxHelper {
  static final HiveBoxHelper boxRepoHive = HiveBoxHelper._internal();

  factory HiveBoxHelper() {
    return boxRepoHive;
  }

  HiveBoxHelper._internal();

  static Future<Box<UserModel>> openUserBox() =>
      Hive.openBox<UserModel>('users');

  static Box<UserModel> getUserBox() => Hive.box<UserModel>('users');

  static Box<String> getBluetoothAddressBox() => Hive.box('BluetoothAddress');
}
