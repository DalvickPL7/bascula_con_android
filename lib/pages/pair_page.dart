import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../helpers/hive_box_helper.dart';

class PairPage extends StatefulWidget {
  const PairPage({super.key});

  @override
  State<PairPage> createState() => _PairPageState();
}

class _PairPageState extends State<PairPage> {
  bool _isConnecting = false;
  List<BluetoothDevice> _devices = [];
  BluetoothConnection? _connection;
  BluetoothDevice? _deviceConnected;
  final _bluetooth = FlutterBluetoothSerial.instance;

  @override
  void initState() {
    _getDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Emparejamiento"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _connection?.isConnected ?? false
                ? FilledButton(
                    child: const Text("Desconectar"),
                    onPressed: () async {
                      await _connection?.finish();
                      setState(() => _deviceConnected = null);
                    },
                  )
                : OutlinedButton(
                    child: const Text("Buscar dispositivos"),
                    onPressed: _getDevices,
                  ),
            _infoDevice(),
            const Divider(),
            Expanded(
              child: _listDevices(),
            ),
          ],
        ),
      ),
    );
  }

  //Muestra a que dispositivo esta conectado
  Widget _infoDevice() {
    return ListTile(
      // tileColor: Colors.black12,
      leading: Icon(Icons.bluetooth),
      title: Text("Conectado a:"),
      // subtitle: Text(_deviceConnected?.name ?? "Ninguno"),
      trailing: Text(_deviceConnected?.name ?? "Ninguno"),
    );
  }

  Widget _listDevices() {
    if(_isConnecting){
      return const Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            for (final device in _devices)
              ListTile(
                onTap: () => _setConnection(device),
                title: Text(device.name ?? device.address),
                trailing: TextButton(
                  child: const Text('Escuchar'),
                  onPressed: () => _setConnection(device),
                ),
              ),
          ],
        ),
      );
    }
  }

  void _setConnection(BluetoothDevice device) async {
    setState(() => _isConnecting = true);

    _connection = await BluetoothConnection.toAddress(
        device.address);
    // _putAddress(device.address);
    _deviceConnected = device;
    _devices = [];
    _isConnecting = false;

    // _receiveData();

    setState(() {});

    Navigator.pop(context, _connection);
  }

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }

  _putAddress(String address){
    var box = HiveBoxHelper.getBluetoothAddressBox();
    box.put('H06', address);
  }
}
