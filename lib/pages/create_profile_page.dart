import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/pages/weight_size_page.dart';
import 'package:flutter_application/widgets/colors.dart';
import 'package:flutter_application/widgets/styles.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  String _imagen = 'assets/images/img_rabano.png';

  final _nombre = TextEditingController();

  bool _masculino = true;

  final _dia = TextEditingController();
  final _mes = TextEditingController();
  final _anio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Hola!", style: MyTextStyle.title),
                const Text(
                  "Empecemos a crear tu perfil",
                  style: MyTextStyle.subtitle,
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "Elige tu Avatar",
                    style: MyTextStyle.titleInputs,
                  ),
                ),
                Center(
                  child: avatar(),
                ),
                const Text("¿Cómo te llamas?", style: MyTextStyle.titleInputs),
                TextFormField(controller: _nombre),
                const SizedBox(height: 32),
                const Text("¿Cúal es tu género?", style: MyTextStyle.titleInputs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _masculino = true;
                        });
                      },
                      color: _masculino ? MyColors.primary : null,
                      iconSize: 48,
                      icon: Icon(Icons.face),
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _masculino = false;
                        });
                      },
                      color: _masculino ? null : MyColors.primary,
                      iconSize: 48,
                      icon: const Icon(Icons.face_3),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text("¿Cúando naciste?", style: MyTextStyle.titleInputs),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _dia,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                    const Text('/'),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _mes,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                    const Text('/'),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _anio,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: FilledButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WeightSizePage(),
                        ),
                      );
                    },
                    child: const Text('Continuar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack avatar() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(_imagen),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: FloatingActionButton.small(
            onPressed: () {},
            backgroundColor: MyColors.primary,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
