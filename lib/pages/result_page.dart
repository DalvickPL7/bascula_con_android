import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/history_model.dart';
import 'package:flutter_application/models/user_model.dart';
import 'package:flutter_application/pages/tip_page.dart';
import 'package:flutter_application/pages/weight_size_page.dart';
import 'package:flutter_application/utils/colors.dart';
import 'package:flutter_application/utils/styles.dart';
import 'package:hive/hive.dart';

import '../helpers/hive_box_helper.dart';
import '../models/imc_model.dart';

class ResultPage extends StatefulWidget {
  final ResultParam param;

  const ResultPage({super.key, required this.param});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late IMCModel imcModel;
  String _textoContinuar = 'Continuar';

  @override
  void initState() {
    imcModel = IMCModel.getImcModel(widget.param.imc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.15,
                      child: Image.asset(
                        imcModel.silueta,
                        height: 300,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(48.0, 48.0, 48.0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Tu peso es:", style: MyTextStyle.title),
                          Image.asset(imcModel.indicador),
                          Center(
                            child: Text(
                              "${widget.param.peso.toStringAsFixed(1)} Kg",
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "${widget.param.talla.toStringAsFixed(1)} cm",
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                color: MyColors.subtitle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text("Tu IMC es:", style: MyTextStyle.title),
                          Center(
                            child: Text(
                              "${widget.param.imc.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              "Indice de masa corporal",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: MyColors.subtitle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
              child: FilledButton(
                onPressed: () async {
                  if (widget.param.newUser != null) {
                    setState(() {
                      _textoContinuar = "Guardando datos...";
                    });
                    await _addUser();
                  } else {
                    setState(() {
                      _textoContinuar = "Guardando datos...";
                    });
                    await _saveUser();
                  }

                  Random random = new Random();
                  int numeroAleatorio = random.nextInt(imcModel.tips.length);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TipPage(
                        tip: imcModel.tips[numeroAleatorio],
                      ),
                    ),
                  );
                },
                child: Text(_textoContinuar),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("¿No es tu peso?",
                    style: MyTextStyle.subtitle.copyWith(letterSpacing: -0.5)),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeightSizePage(
                          param: widget.param.newUser,
                          user: widget.param.user,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Sube de nuevo a la balanza',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, letterSpacing: -0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addUser() async {
    Box<UserModel> userBox = await HiveBoxHelper.openUserBox();
    final id = generateUuid();
    final user = widget.param.newUser!;
    await userBox.put(
      id,
      UserModel(
        uid: id,
        avatar: user.avatar,
        nombre: user.nombre,
        isMasculino: user.isMasculino,
        fechaNacimiento: user.fechaNacimiento,
        pesoActual: widget.param.peso,
        tallaActual: widget.param.talla,
        imcActual: widget.param.imc,
        historial: [
          HistoryModel(
            peso: widget.param.peso,
            talla: widget.param.talla,
            imc: widget.param.imc,
            fecha: DateTime.now(),
          ),
        ],
      ),
    );
  }

  Future<void> _saveUser() async {
    Box<UserModel> userBox = await HiveBoxHelper.openUserBox();
    final UserModel user = widget.param.user!;
    await userBox.put(
      user.uid,
      UserModel(
        uid: user.uid,
        avatar: user.avatar,
        nombre: user.nombre,
        isMasculino: user.isMasculino,
        fechaNacimiento: user.fechaNacimiento,
        pesoActual: widget.param.peso,
        tallaActual: widget.param.talla,
        imcActual: widget.param.imc,
        historial: [
          HistoryModel(
            peso: widget.param.peso,
            talla: widget.param.talla,
            imc: widget.param.imc,
            fecha: DateTime.now(),
          ),
          ...user.historial,
        ],
      ),
    );
  }

  static String generateUuid() {
    final Random random = Random();

    String generateRandomHex(int length) {
      String result = "";
      for (int i = 0; i < length; i++) {
        result += random.nextInt(16).toRadixString(16);
      }
      return result;
    }

    return "${generateRandomHex(8)}-${generateRandomHex(4)}-4${generateRandomHex(3)}-a${generateRandomHex(3)}-${generateRandomHex(12)}";
  }
}

class ResultParam {
  final WeightSizeParam? newUser;
  final UserModel? user;
  final double peso; //en cm
  final double talla; //en kg
  final double imc;

  const ResultParam({
    required this.newUser,
    required this.user,
    required this.peso,
    required this.talla,
    required this.imc,
  });
}
