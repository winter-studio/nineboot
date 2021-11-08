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
      home: SafeArea(
          child: Scaffold(
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: const MyStatefulWidget()),
      )),
    );
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: const [
                Icon(
                  Icons.run_circle,
                  color: Colors.blueGrey,
                  size: 120,
                ),
                Text(
                  'NineBoot',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 30.0),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(children: [
          Expanded(
              child: InputDecorator(
            decoration: InputDecoration(
                labelText: '代码',
                labelStyle: const TextStyle(color: Colors.blue, fontSize: 16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
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
        ]),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: TextField(
              enabled: false,
              controller: _selectedDevice,
              decoration: InputDecoration(
                  labelText: '选择蓝牙设备',
                  labelStyle:
                      const TextStyle(color: Colors.blue, fontSize: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
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
                    onPressed: () => {debugPrint('SEARCH BLUETOOTH DEVICES')})),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 120,
                height: 50,
                child: MaterialButton(
                    elevation: 5,
                    color: Colors.green,
                    textColor: Colors.white,
                    splashColor: Colors.blue,
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const <Widget>[
                        Text(
                          "发 送",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        Icon(Icons.upload),
                      ],
                    ),
                    onPressed: () => {debugPrint('SEND DATA')}))
          ],
        )
      ],
    );
  }
}
