import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BluetoothDevicesDialog extends StatefulWidget {
  const BluetoothDevicesDialog({Key? key}) : super(key: key);

  @override
  _BluetoothListState createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothDevicesDialog> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = [];
  StreamSubscription<List<ScanResult>>? scanSubscription;
  ScanResult? selectedDevice;
  bool isLoading = false;
  Stream<bool>? isScanning;
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _stopScan();
    isScanning = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isScanning = flutterBlue.isScanning;
    isScanning?.listen((event) {
      if (event != isLoading && mounted) {
        setState(() {
          log(event.toString());
          isLoading = event;
        });
      }
    });
    _startScan();
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
              ? SizedBox(
            width: 120,
            child: Column(
              children: const [
                Text(
                  '停止扫描',
                  style:
                  TextStyle(fontSize: 18, color: Colors.deepOrange),
                ),
                SizedBox(
                    width: 70,
                    height: 3,
                    child: LinearProgressIndicator(
                      color: Colors.deepOrange,
                    ))
              ],
            ),
          )
              : const Text(
            '重新扫描',
            style: TextStyle(fontSize: 18, color: Colors.green),
          ),
          onPressed: () {
            if (isLoading) {
              _stopScan();
            } else {
              _startScan();
            }
          },
        ),
        TextButton(
          child: const Text(
            '确定',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            if (selectedDevice == null) {
              Fluttertoast.showToast(
                  msg: "请选择设备",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else {
              Navigator.pop(context, selectedDevice?.device);
            }
          },
        ),
      ],
      content: Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          thickness: 3,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller:_scrollController,
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
                          minHeight: MediaQuery
                              .of(context)
                              .size
                              .height * 0.6,
                          maxHeight: MediaQuery
                              .of(context)
                              .size
                              .height * 0.6,
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: scanResults.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                  title: _buildBluetoothItem(index),
                                  value: scanResults[index],
                                  groupValue: selectedDevice,
                                  onChanged: (value) =>
                                      setState(() {
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

  void _startScan() {
    log("start scan");
    setState(() {
      selectedDevice = null;
      isLoading = true;
    });
    flutterBlue.startScan();

    scanSubscription = flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResults = results.toList();
      });
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
                _buildSignalIcon(scanResult.rssi),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildSignalIcon(int rssi) {
    int emptyBlock = (0 - rssi - 60) % 7;
    emptyBlock = math.min(emptyBlock, 5);
    List<Container> blocks = [];

    for (int i = 0; i < 5 - emptyBlock; i++) {
      blocks.add(Container(
        color: Colors.blueGrey,
        width: 4,
        height: i * 4 + 6,
      ));
    }
    for (int i = 5 - emptyBlock; i < 5; i++) {
      blocks.add(Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey)),
        width: 4,
        height: i * 4 + 6,
      ));
    }

    return SizedBox(
      width: 24,
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: blocks,
      ),
    );
  }
}
