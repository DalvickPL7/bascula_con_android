import 'package:flutter/material.dart';

class SelectAvatarPage extends StatelessWidget {
  const SelectAvatarPage({super.key});

  static final avatars = [
    "assets/images/img_fruta.png",
    "assets/images/img_frutilla.png",
    "assets/images/img_kiwi.png",
    "assets/images/img_limon.png",
    "assets/images/img_mango.png",
    "assets/images/img_manzana.png",
    "assets/images/img_melon.png",
    "assets/images/img_naranja.png",
    "assets/images/img_pera.png",
    "assets/images/img_pera2.png",
    "assets/images/img_pina.png",
    "assets/images/img_platano.png",
    "assets/images/img_rabano.png",
    "assets/images/img_uva.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecciona tu avatar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: List.generate(
            avatars.length,
            (index) => InkWell(
              onTap: () {
                Navigator.pop(context, avatars[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  avatars[index],
                  height: 64,
                ),
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
