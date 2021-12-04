import 'dart:async';
import 'dart:developer';

import 'package:convert/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:nineboot/toast_message.dart';

import 'bluetooth_devices_dialog.dart';
import 'generated/l10n.dart';
import 'local_storage.dart';

class AppContent extends StatefulWidget {
  const AppContent({Key? key}) : super(key: key);

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  static const String _ninebotServiceId =
      "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  static const String _ninebotCharacteristicsId =
      "6e400002-b5a3-f393-e0a9-e50e24dcca9e";

  final Map<String, String> _codes = {
    '5AA5007057457776656E467A39': '(old)5AA5007057457776656E467A39',
    '5AA500324357736C4C54413872': '(new)5AA500324357736C4C54413872'
  };
  String _selectedCode = '5AA5007057457776656E467A39';
  BluetoothDevice? _device;
  final _selectedDeviceId =
      TextEditingController(text: LocalStorage().getAutoConnect());
  bool _isSending = false;
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: _buildFields(),
      ),
    );
  }

  SizedBox _buildRowSpacing() => const SizedBox(height: 20);

  List<Widget> _buildCodeField() {
    return [
      Expanded(
          child: InputDecorator(
        decoration: InputDecoration(
            labelText: S.of(context).code,
            labelStyle: const TextStyle(color: Colors.blue, fontSize: 16.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedCode,
            isDense: true,
            style: const TextStyle(color: Colors.black54, fontSize: 16.0),
            onChanged: (value) => {
              setState(() {
                _selectedCode = value!;
              })
            },
            items: _codes.entries.map((e) {
              return DropdownMenuItem<String>(
                value: e.key,
                child: Text(e.value),
              );
            }).toList(),
          ),
        ),
      ))
    ];
  }

  List<Widget> _buildBluetoothField() {
    return [
      Expanded(
          child: TextField(
        enabled: false,
        controller: _selectedDeviceId,
        decoration: InputDecoration(
            labelText: S.of(context).selectedDevice,
            labelStyle: const TextStyle(color: Colors.blue, fontSize: 16.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      )),
      Container(
          margin: const EdgeInsets.only(left: 6),
          height: 50,
          child: MaterialButton(
              elevation: 5,
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.blue,
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    S.of(context).searchDevice,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  const Icon(Icons.search),
                ],
              ),
              onPressed: () async {
                showDialog(
                        context: context,
                        builder: (builder) => const BluetoothDevicesDialog(),
                        barrierDismissible: false)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _device = value;
                      _selectedDeviceId.text = _device!.id.id;
                    });
                  }
                });
              })),
    ];
  }

  SizedBox _buildSendButton() {
    return SizedBox(
        width: 150,
        height: 150,
        child: _isSending
            ? const CircularProgressIndicator(
                color: Colors.orange,
                strokeWidth: 8,
              )
            : MaterialButton(
                elevation: 5,
                color: Colors.green,
                textColor: Colors.white,
                splashColor: Colors.blue,
                padding: const EdgeInsets.all(6),
                shape: const CircleBorder(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      S.of(context).send,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 46.0),
                    ),
                  ],
                ),
                onPressed: () => _sendData()));
  }

  Future<void> _sendData() async {
    if (_device == null &&
        _selectedDeviceId.text == TextEditingValue.empty.text) {
      ToastMessage.error(S.of(context).searchDeviceTip);
    }

    _updateSendingState(true);

    if (_device == null) {
      ToastMessage.info(S.of(context).tryToSearch);

      _flutterBlue.scanResults.listen((List<ScanResult> results) {
        if (results.toList().isNotEmpty) {
          _flutterBlue.stopScan();
          setState(() {
            _device = results.toList()[0].device;
          });
        }
      });

      // search device by guid
      await _flutterBlue.startScan(
          withDevices: [Guid.fromMac(_selectedDeviceId.text)],
          timeout: const Duration(seconds: 10));

      if (_device == null) {
        _updateSendingState(false);
        ToastMessage.error(S.of(context).deviceNotFound);
        _flutterBlue.stopScan();
        return;
      }
    }

    await _device!
        .connect(autoConnect: false)
        .timeout(const Duration(seconds: 5), onTimeout: () {
      ToastMessage.error(S.of(context).connectTimeout);
      _device!.disconnect();
      return;
    }).onError((error, stackTrace) {
      //ignore
      log(error.toString());
    });

    try {
      List<BluetoothService> services = await _device!.discoverServices();

      BluetoothCharacteristic c = services
          .firstWhere((service) =>
              service.uuid.toString().toLowerCase() == _ninebotServiceId)
          .characteristics
          .firstWhere((c) =>
              c.uuid.toString().toLowerCase() == _ninebotCharacteristicsId);

      c.write(hex.decode(_selectedCode));
    } on StateError catch (e) {
      log(e.message);
      ToastMessage.error(S.of(context).characteristicNotFound);
    } on Error catch (e) {
      log(e.stackTrace.toString());
      ToastMessage.error(S.of(context).unknownError + " : " + e.toString());
    } finally {
      _device!.disconnect();
      _updateSendingState(false);
    }
  }

  void _updateSendingState(state) {
    setState(() {
      _isSending = state;
    });
  }

  List<Widget> _buildFields() {
    return [
      _buildRowSpacing(),
      Row(children: _buildCodeField()),
      _buildRowSpacing(),
      Row(children: _buildBluetoothField()),
      _buildRowSpacing(),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildSendButton()])
    ];
  }
}
