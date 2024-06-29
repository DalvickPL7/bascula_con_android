import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/helpers/hive_box_helper.dart';
import 'package:flutter_application/models/user_model.dart';
import 'package:flutter_application/pages/pair_page.dart';
import 'package:flutter_application/pages/result_page.dart';
import 'package:flutter_application/utils/styles.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/imc_model.dart';

class WeightSizePage extends StatefulWidget {
  final WeightSizeParam? param;
  final UserModel? user;

  const WeightSizePage({super.key, this.param, this.user});

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

  String buffer = '';

  String _pesoRecibido = '';
  double? _peso = null;
  String _alturaRecibido = '';
  double? _altura = null;

  @override
  void initState() {
    super.initState();
    _requestPermission();

    print('  >>>  _WeightSizePageState‐initState» _bluetooth.name» ${_bluetooth.name}');
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

  _getAddress() async {
    var box = HiveBoxHelper.getBluetoothAddressBox();
    var name = box.get('H06');
    if (name != null && name.isNotEmpty) {
      _connection = await BluetoothConnection.toAddress(name);
    }
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
                      "${_altura?.toStringAsFixed(2) ?? ''} cm",
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
                      _pesoRecibido,
                      // "${_peso?.toStringAsFixed(2) ?? ''} Kg",
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
              onPressed: _peso != null && _altura != null
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            param: ResultParam(
                              newUser: widget.param,
                              user: widget.user,
                              peso: _peso!,
                              talla: _altura!,
                              imc: IMCModel.calcularIMC(_peso!, _altura!),
                            ),
                          ),
                        ),
                      );
                    }
                  : null,
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
      (Uint8List data) {
        String receivedData = ascii.decode(data);
        buffer += receivedData;

        int index;
        while ((index = buffer.indexOf('\n')) != -1) {
          String message = buffer.substring(0, index).trim();
          buffer = buffer.substring(index + 1);

          print("====> $message");
          if (message.contains('P')) {
            setState(() {
              _pesoRecibido = message.replaceAll('P', '');
              _peso = double.tryParse(_pesoRecibido);
            });
          } else if (message.contains('T')) {
            setState(() {
              _alturaRecibido = message.replaceAll('T', '');
              _altura = double.tryParse(_alturaRecibido);
            });
          }
        }

        if (ascii.decode(data).contains('!')) {
          // connection.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      },
    );
  }
}

class WeightSizeParam {
  final String nombre;
  final bool isMasculino;
  final DateTime fechaNacimiento;
  final String avatar;

  const WeightSizeParam({
    required this.avatar,
    required this.nombre,
    required this.isMasculino,
    required this.fechaNacimiento,
  });
}
