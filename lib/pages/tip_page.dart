import 'package:flutter/material.dart';

import '../models/tip_model.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';

class TipPage extends StatelessWidget {
  final TipModel tip;

  const TipPage({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("CONSEJO", style: MyTextStyle.title),
                    SizedBox(height: 24),
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
                    SizedBox(height: 16),
                    Text(tip.texto, style: MyTextStyle.subtitle),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
