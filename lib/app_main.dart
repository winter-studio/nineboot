import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_logo.dart';
import 'bluetooth_devices_dialog.dart';

class AppMain extends StatefulWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  final Map<String, String> _codes = {
    '5AA5007057457776656E467A39': '(旧代码)5AA5007057457776656E467A39',
    '5AA500324357736C4C54413872': '(新代码)5AA500324357736C4C54413872'
  };
  String? _selectedCode = '5AA5007057457776656E467A39';
  final _selectedDevice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [AppLogo()]),
        _buildRowSpacing(),
        Row(children: _buildCodeField()),
        _buildRowSpacing(),
        Row(children: _buildBluetoothField()),
        _buildRowSpacing(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildSendButton()])
      ],
    );
  }

  SizedBox _buildRowSpacing() => const SizedBox(height: 20);

  List<Widget> _buildCodeField() {
    return [
      Expanded(
          child: InputDecorator(
        decoration: InputDecoration(
            labelText: '代码',
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
                _selectedCode = value;
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
        controller: _selectedDevice,
        decoration: InputDecoration(
            labelText: '选择蓝牙设备',
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
                children: const <Widget>[
                  Text(
                    "搜索设备",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  Icon(Icons.search),
                ],
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (builder) => const BluetoothDevicesDialog(),
                  barrierDismissible: false))),
    ];
  }

  SizedBox _buildSendButton() {
    return SizedBox(
        width: 150,
        height: 150,
        child: MaterialButton(
            elevation: 5,
            color: Colors.green,
            textColor: Colors.white,
            splashColor: Colors.blue,
            padding: const EdgeInsets.all(6),
            shape: const CircleBorder(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                Text(
                  "发 送",
                  style: TextStyle(color: Colors.white, fontSize: 46.0),
                ),
              ],
            ),
            onPressed: () => {
                  if (_selectedDevice.value.text.isEmpty){
                      Fluttertoast.showToast(
                          msg: "请先搜索并选择设备",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0)
                    }
                }));
  }
}
