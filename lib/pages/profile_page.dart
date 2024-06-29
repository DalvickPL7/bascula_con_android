import 'package:flutter/material.dart';
import 'package:flutter_application/models/imc_model.dart';
import 'package:flutter_application/pages/weight_size_page.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../helpers/hive_box_helper.dart';
import '../models/user_model.dart';
import '../utils/colors.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserModel user;
  late IMCModel imc;
  final DateFormat formatter = DateFormat.yMd().add_jm();

  @override
  void initState() {
    user = widget.user;
    imc = IMCModel.getImcModel(user.imcActual);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeightSizePage(
                    user: user,
                  ),
                ),
              );
              await _refreshUser();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 56,
                  backgroundColor: Colors.grey[200],
                  child: Image.asset(user.avatar),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "IMC ${user.imcActual.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: MyColors.subtitle,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: imc.color,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Text(
                          imc.nombre,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Peso:",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: MyColors.subtitle,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${user.pesoActual.toStringAsFixed(2)} Kg",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Talla:",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: MyColors.subtitle,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${user.tallaActual.toStringAsFixed(2)} cm",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Fecha",
                    style: TextStyle(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Talla",
                    style: TextStyle(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Peso",
                    style: TextStyle(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  return _refreshUser();
                },
                child: ListView.builder(
                  itemCount: user.historial.length,
                  itemBuilder: (context, index) {
                    final item = user.historial[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              formatter.format(item.fecha),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              item.talla.toStringAsFixed(2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              item.peso.toStringAsFixed(2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshUser() async {
    Box<UserModel> userBox = await HiveBoxHelper.openUserBox();
    UserModel? userModel = userBox.get(widget.user.uid);
    print('  >>>  _ProfilePageState‐_refreshUser» » ${userModel?.nombre}');
    if (userModel != null) {
      setState(() {
        user = userModel;
      });
    }
  }
}
