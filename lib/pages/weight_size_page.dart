import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/pair_page.dart';
import 'package:flutter_application/pages/result_page.dart';
import 'package:flutter_application/widgets/styles.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class WeightSizePage extends StatefulWidget {
  const WeightSizePage({super.key});

  @override
  State<WeightSizePage> createState() => _WeightSizePageState();
}

class _WeightSizePageState extends State<WeightSizePage> {
  //inicia el bluethoot
  final _bluetooth = FlutterBluetoothSerial.instance;

  //guarda el estado del bluethoot
  bool _bluetoothState = false;

  //es el quien guarda la direccion/nombre del dispositivo conectado
  BluetoothConnection? _connection;

  String _pesoRecibido = '';
  String _alturaRecibido = '';

  @override
  void initState() {
    super.initState();
    _requestPermission();

    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });

    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(""),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PairPage(),
                ),
              );

              if (result != null) {
                _connection = result;
                _receiveData();
              }
            },
            icon: Icon(
              Icons.bluetooth,
              color: _bluetoothState ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                children: [
                  const Text("Sube a la balanza!", style: MyTextStyle.title),
                  const Text(
                    "y quédate quieto por unos segundos",
                    style: MyTextStyle.subtitle,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Talla",
                      style: MyTextStyle.titleInputs.copyWith(fontSize: 24),
                    ),
                  ),
                  Center(
                    child: Text(
                      "177${_pesoRecibido} cm",
                      style: TextStyle(fontSize: 56),
                    ),
                  ),
                  SizedBox(height: 56),
                  Center(
                    child: Text(
                      "Peso",
                      style: MyTextStyle.titleInputs.copyWith(fontSize: 24),
                    ),
                  ),
                  Center(
                    child: Text(
                      "1323${_alturaRecibido} Kg",
                      style: TextStyle(fontSize: 56),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResultPage(),
                  ),
                );
              },
              child: Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }

  //Este metodo pide permisos
  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  void _receiveData() {
    _connection?.input?.listen(
      (event) {
        // Allocate buffer for parsed data
        int backspacesCounter = 0;
        event.forEach((byte) {
          if (byte == 8 || byte == 127) {
            backspacesCounter++;
          }
        });
        print("event: $event");
        print("buffer: ${event.length} - ${backspacesCounter}");
        Uint8List buffer = Uint8List(event.length - backspacesCounter);
        int bufferIndex = buffer.length;

        // Apply backspace control character
        backspacesCounter = 0;
        for (int i = event.length - 1; i >= 0; i--) {
          if (event[i] == 8 || event[i] == 127) {
            backspacesCounter++;
          } else {
            if (backspacesCounter > 0) {
              backspacesCounter--;
            } else {
              buffer[--bufferIndex] = event[i];
            }
          }
        }

        // Create message if there is new line character
        print("\n ====> " + String.fromCharCodes(buffer));
        setState(() {
          _pesoRecibido = "${String.fromCharCodes(buffer)}";
          _alturaRecibido = "${String.fromCharCodes(buffer)}";
        });
        // message = String.fromCharCodes(event);
        // if (String.fromCharCodes(event) == "p") {
        // }
      },
    );
  }
}
