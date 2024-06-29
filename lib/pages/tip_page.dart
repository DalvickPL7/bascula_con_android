import 'package:flutter/material.dart';

import '../models/tip_model.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import 'home_page.dart';

class TipPage extends StatelessWidget {
  final TipModel tip;

  const TipPage({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text("CONSEJO", style: MyTextStyle.title),
                  if (tip.imagen.isNotEmpty)
                    Image.asset(tip.imagen, height: 200),
                  Text(
                    tip.titulo,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: MyColors.title,
                    ),
                  ),
                  Text(tip.texto, style: MyTextStyle.subtitle),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
