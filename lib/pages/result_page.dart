import 'package:flutter/material.dart';
import 'package:flutter_application/pages/tip_page.dart';
import 'package:flutter_application/pages/weight_size_page.dart';
import 'package:flutter_application/widgets/colors.dart';
import 'package:flutter_application/widgets/styles.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String _graficoImc = 'assets/images/indicador_saludable.png';
  String _personaImc = 'assets/images/silueta_m_saludable.png';

  double peso = 37.00;
  double talla = 177.20;
  double imc = 20.35;

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
                        _personaImc,
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
                          Image.asset(_graficoImc),
                          Center(
                            child: Text(
                              "${peso.toStringAsFixed(1)} Kg",
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "${talla.toStringAsFixed(1)} cm",
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                color: MyColors.subtitle,
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                          Text("Tu IMC es:", style: MyTextStyle.title),
                          Center(
                            child: Text(
                              "${imc.toStringAsFixed(2)}",
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
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TipPage(),
                    ),
                  );
                },
                child: Text('Continuar'),
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
                        builder: (context) => const WeightSizePage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sube de nuevoa la balanza',
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
}
