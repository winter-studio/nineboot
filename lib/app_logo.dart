import 'package:flutter/material.dart';
import 'package:nineboot/tools/rive_controller.dart';
import 'package:rive/rive.dart';

const assetsImagePath = "assets/images/logo.png";
const assetsAnimationBike = "assets/animation/bike.riv";

class AppLogo extends StatefulWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  _AppLogoState createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  late double _height;

  @override
  void initState() {
    super.initState();
    setState(() {
      _height = 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      if (constraints.maxWidth != 0) {
        var mediaWidth = MediaQuery.of(context).size.width;
        return Container(
          color: Colors.black12,
          width: mediaWidth,
          height: _height,
          alignment: Alignment.center,
          child: RiveAnimation.asset(assetsAnimationBike,
              fit: BoxFit.fitWidth,
              placeHolder: const SizedBox(
                height: 5,
                width: 100,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.blueGrey,
                  color: Colors.blue,
                ),
              ),
              onInit: (Artboard artboard) =>
                  {_onRiveInit(artboard, mediaWidth)}),
        );
      }
      return Container();
    });
  }

  void _onRiveInit(Artboard artboard, double mediaWidth) {
    double height = mediaWidth * artboard.height / artboard.width;
    setState(() {
      _height = height;
    });
    final controller = StateMachineController.fromArtboard(artboard, 'press');
    artboard.addController(controller!);
    SMIBool _pressed = controller.findInput<bool>('pressed') as SMIBool;
    RiveController.init(_pressed);
  }
}
