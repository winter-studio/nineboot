import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'NineBoot';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body: Container(
              margin: const EdgeInsets.all(12.0),
              child: const MyStatefulWidget()),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
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
        InputDecorator(
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
        ),
        const SizedBox(height: 20),
        TextField(
          enabled: false,
          controller: _selectedDevice,
          decoration: InputDecoration(
              hintText: '点击选择蓝牙设备',
              labelText: '蓝牙设备',
              hintStyle: const TextStyle(color: Colors.blue, fontSize: 16.0),
              labelStyle: const TextStyle(color: Colors.blue, fontSize: 16.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        ),
      ],
    );
  }
}
