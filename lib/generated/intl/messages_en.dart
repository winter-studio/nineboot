// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "characteristicNotFound": MessageLookupByLibrary.simpleMessage(
            "could not find the characteristic of ninebot"),
        "code": MessageLookupByLibrary.simpleMessage("Code"),
        "confirm": MessageLookupByLibrary.simpleMessage("confirm"),
        "connectTimeout":
            MessageLookupByLibrary.simpleMessage("connect device timeout"),
        "deviceList": MessageLookupByLibrary.simpleMessage("Devices"),
        "deviceNotFound": MessageLookupByLibrary.simpleMessage(
            "device not found, ensure your device is nearby"),
        "scanAgain": MessageLookupByLibrary.simpleMessage("Scan Again"),
        "searchDevice": MessageLookupByLibrary.simpleMessage("search"),
        "searchDeviceTip": MessageLookupByLibrary.simpleMessage(
            "please search and select your device."),
        "selectDeviceTip":
            MessageLookupByLibrary.simpleMessage("please select your device."),
        "selectedDevice":
            MessageLookupByLibrary.simpleMessage("Selected Device"),
        "send": MessageLookupByLibrary.simpleMessage("SEND"),
        "stopScan": MessageLookupByLibrary.simpleMessage("Stop Scan"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("Unknown"),
        "unknownError": MessageLookupByLibrary.simpleMessage("Unknown Error")
      };
}
