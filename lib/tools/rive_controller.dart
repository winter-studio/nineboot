import 'package:rive/src/controllers/state_machine_controller.dart';

class RiveController {
  static SMIBool? _pressed;

  static void init(SMIBool pressed) {
    _pressed = pressed;
  }

  static void pressed(bool bool) {
    _pressed!.value = bool;
  }
}
