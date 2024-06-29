import 'package:flutter/material.dart';
import 'package:flutter_application/models/history_model.dart';
import 'package:flutter_application/models/imc_model.dart';
import 'package:flutter_application/pages/create_profile_page.dart';
import 'package:flutter_application/pages/profile_page.dart';
import 'package:hive/hive.dart';

import '../helpers/hive_box_helper.dart';
import '../models/user_model.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> users = [];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mi Familia",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateProfilePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: MyColors.primary,
            ),
          ),
        ],
      ),
      body: users.isNotEmpty
          ? _usersView()
          : Center(
              child: FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Agregar nuevo usuario"),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateProfilePage(),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget _usersView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 24.0),
          child: Text(
            'IMC',
            textAlign: TextAlign.end,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        const Divider(
          indent: 64,
          endIndent: 16,
          color: Colors.grey,
        ),
        SizedBox(
          height: 172,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      IMCModel.getImcModel(user.imcActual).silueta,
                      height: 96,
                    ),
                    Text(
                      user.imcActual.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      user.nombre,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        _title(),
        const Divider(indent: 64, endIndent: 16),
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(user: user),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[200],
                          child: Image.asset(user.avatar),
                        ),
                      ),
                      Expanded(flex: 3, child: Text(user.nombre)),
                      Expanded(
                          flex: 1,
                          child: Text(
                            user.tallaActual.toStringAsFixed(2),
                            textAlign: TextAlign.end,
                          )),
                      Expanded(
                        flex: 1,
                        child: Text(
                          user.pesoActual.toStringAsFixed(2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(width: 56),
          Expanded(
              flex: 3,
              child: Text(
                'Nombre',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700),
              )),
          Expanded(
            flex: 1,
            child: Text(
              'Peso',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Talla',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  void getUsers() async {
    Box<UserModel> usersBox = await HiveBoxHelper.openUserBox();
    setState(() {
      users = usersBox.values.toList();
    });
  }
}
