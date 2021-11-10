import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const assetsImagePath = "assets/images/logo.png";

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _loadFromAssets(),
          const Text(
            'NineBoot',
            style: TextStyle(color: Colors.blueGrey, fontSize: 36.0),
          )
        ],
      ),
    );
  }

  Widget _loadFromAssets() => Container(
      width: 120,
      height: 120,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black26,
      ),
      child: SizedBox(
        height: 80,
        width: 80,
        child: Image.asset(
          assetsImagePath,
        ),
      ));
}
