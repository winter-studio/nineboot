import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BluetoothDevicesDialog extends StatefulWidget {
  const BluetoothDevicesDialog({Key? key}) : super(key: key);

  @override
  _BluetoothList createState() => _BluetoothList();
}

class _BluetoothList extends State<BluetoothDevicesDialog> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = [];
  StreamSubscription<List<ScanResult>>? scanSubscription;
  ScanResult? selectedDevice;
  bool isLoading = false;

  @override
  void dispose() {
    _stopScan();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterBlue.isScanning.listen((event) {
      setState(() {
        log(event.toString());
        isLoading = event;
      });
    });
    _startScan(10);
  }

  void _stopScan() {
    log("stop scan");
    flutterBlue.stopScan();
    scanSubscription?.cancel();
    scanSubscription = null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('蓝牙列表'),
      titleTextStyle: const TextStyle(color: Colors.blue, fontSize: 18),
      contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      buttonPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          child: const Text(
            '取消',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: isLoading
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  width: 24,
                  height: 24,
                  child: const CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : const Text(
                  '重新扫描',
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
          onPressed: () {
            if (!isLoading) {
              _startScan(5);
            }
          },
        ),
        TextButton(
          child: const Text(
            '确定',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            //widget.onOk();
            Fluttertoast.showToast(
                msg: "This is Center Short Toast",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            // Navigator.pop(context);
          },
        ),
      ],
      content: Scrollbar(
          isAlwaysShown: true,
          thickness: 2,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Divider(
                        height: 0,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.6,
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: scanResults.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                  title: _buildBluetoothItem(index),
                                  value: scanResults[index],
                                  groupValue: selectedDevice,
                                  onChanged: (value) => setState(() {
                                        selectedDevice = value as ScanResult?;
                                      }));
                            }),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      )
                    ],
                  )))),
    );
  }

  void _startScan(int durationInSecond) {
    log("start scan");
    setState(() {
      isLoading = true;
    });
    flutterBlue.startScan(timeout: Duration(seconds: durationInSecond));

    scanSubscription = flutterBlue.scanResults.listen((results) {
      setState(() {
        for (var result in results) {
          if (!scanResults.contains(result)) {
            scanResults.add(result);
          }
        }
      });

      log(scanResults.toString());
    }, onDone: () => {_stopScan()});
  }

  Widget _buildBluetoothItem(int index) {
    ScanResult scanResult = scanResults[index];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                scanResult.device.name.isEmpty
                    ? '未知设备'
                    : scanResult.device.name,
                style: const TextStyle(color: Colors.grey),
              ),
              Text(scanResult.device.id.id),
            ]),
            Column(
              children: [
                const Icon(Icons.signal_cellular_alt),
                Text("${scanResult.rssi}db"),
              ],
            )
          ],
        )
      ],
    );
  }
}
