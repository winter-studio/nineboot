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
  FlutterBlue flutterBlue = FlutterBlue.instance;

  final List<BluetoothDevice> devices = [];

  var _selected;

  @override
  Widget build(BuildContext context) {
    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

    flutterBlue.startScan(timeout: const Duration(seconds: 15));

    return AlertDialog(
      title: const Text('蓝牙列表'),
      titleTextStyle: const TextStyle(color: Colors.blue, fontSize: 18),
      contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      buttonPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          child: const Text(
            '确 定',
            style: TextStyle(fontSize: 16),
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
                fontSize: 16.0
            );
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
                          maxHeight: MediaQuery
                              .of(context)
                              .size
                              .height * 0.6,
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: devices.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                  title: Text(devices[index].id.id),
                                  value: index,
                                  groupValue: _selected,
                                  onChanged: (value) =>
                                  {
                                    setState(() => {_selected = value})
                                  });
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

}
