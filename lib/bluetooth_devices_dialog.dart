import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:nineboot/local_storage.dart';
import 'package:nineboot/toast_message.dart';

class BluetoothDevicesDialog extends StatefulWidget {
  const BluetoothDevicesDialog({Key? key}) : super(key: key);

  @override
  _BluetoothListState createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothDevicesDialog> {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  List<ScanResult> _scanResults = [];
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  ScanResult? _selectedDevice;
  bool _isLoading = false;
  Stream<bool>? _isScanning;
  final ScrollController _scrollController = ScrollController();
  late List<String> _myFavorites;

  _BluetoothListState() {
    _myFavorites = LocalStorage().getMyFavorites();
  }

  @override
  void dispose() {
    _stopScan();
    _isScanning = null;
    // save _myFavorites
    LocalStorage().setMyFavorites(_myFavorites);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isScanning = _flutterBlue.isScanning;
    _isScanning?.listen((event) {
      if (event != _isLoading && mounted) {
        setState(() {
          log(event.toString());
          _isLoading = event;
        });
      }
    });
    _startScan();
  }

  void _stopScan() {
    log("stop scan");
    _flutterBlue.stopScan();
    _scanSubscription?.cancel();
    _scanSubscription = null;
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
          child: _isLoading
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
            if (_isLoading) {
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
            if (_selectedDevice == null) {
              ToastMessage.error("请选择设备");
            } else {
              Navigator.pop(context, _selectedDevice?.device);
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
              controller: _scrollController,
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
                          minHeight: MediaQuery.of(context).size.height * 0.6,
                          maxHeight: MediaQuery.of(context).size.height * 0.6,
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _scanResults.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                  title: _buildBluetoothItem(index),
                                  value: _scanResults[index],
                                  groupValue: _selectedDevice,
                                  onChanged: (value) => setState(() {
                                        _selectedDevice = value as ScanResult?;
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
      _selectedDevice = null;
      _isLoading = true;
    });
    _flutterBlue.startScan();

    _scanSubscription = _flutterBlue.scanResults.listen((results) {
      setState(() {
        _scanResults = results.toList();
      });
    }, onDone: () => {_stopScan()});
  }

  Widget _buildBluetoothItem(int index) {
    ScanResult scanResult = _scanResults[index];
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scanResult.device.name.isEmpty
                          ? '未知设备'
                          : scanResult.device.name,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(scanResult.device.id.id),
                  ]),
            ),
            Column(
              children: [
                _buildSignalIcon(scanResult.rssi),
              ],
            ),
            Column(
              children: [
                _buildFavoriteButton(scanResult.device.id.id),
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

    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 24,
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: blocks,
      ),
    );
  }

  Widget _buildFavoriteButton(String id) {
    return Container(
        margin: const EdgeInsets.only(left: 8),
        child: IconButton(
            icon: Icon(
              Icons.star,
              size: 26,
              color: _myFavorites.contains(id) ? Colors.orange : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                if (_myFavorites.contains(id)) {
                  _myFavorites.remove(id);
                } else {
                  _myFavorites.add(id);
                }
              });
            }));
  }
}
