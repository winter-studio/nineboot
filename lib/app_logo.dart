import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
