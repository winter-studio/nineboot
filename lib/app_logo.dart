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
  final StateMachineController _controller =
      StateMachineController(StateMachine());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: _height,
            child: RiveAnimation.asset(assetsAnimationBike,
                fit: BoxFit.fitWidth,
                controllers: [_controller],
                stateMachines: const ["press"],
                onInit: (Artboard artboard) => {
                      setState(() {
                        _height = artboard.height;
                      })
                    })),
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: const Text(
            'NineBoot',
            style: TextStyle(fontSize: 50, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
