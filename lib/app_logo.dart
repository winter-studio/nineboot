import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

const assetsImagePath = "assets/images/logo.png";
const assetsAnimationBike = "assets/animation/bike.riv";

class AppLogo extends StatefulWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  _AppLogoState createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  double _height = 0;

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery
        .of(context)
        .size
        .width;

    return SizedBox(
        width: mediaWidth,
        height: _height,
        child: RiveAnimation.asset(assetsAnimationBike,
            fit: BoxFit.fitWidth,
            stateMachines: const ["press"],
            onInit: (Artboard artboard) =>
            {_onRiveInit(artboard, mediaWidth)}));
  }

  void _onRiveInit(Artboard artboard, double mediaWidth) {
    setState(() {
      _height = mediaWidth * artboard.height / artboard.width;
    });
    final controller = StateMachineController.fromArtboard(artboard, 'press');
    artboard.addController(controller!);
    SMIBool _pressed = controller.findInput<bool>('pressed') as SMIBool;
    _pressed.value = true;
  }
}
