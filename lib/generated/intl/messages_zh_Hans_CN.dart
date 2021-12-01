// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hans_CN locale. All the
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
  String get localeName => 'zh_Hans_CN';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "boot": MessageLookupByLibrary.simpleMessage("发 送"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "characteristicNotFound":
            MessageLookupByLibrary.simpleMessage("找不到九号车的特征值"),
        "code": MessageLookupByLibrary.simpleMessage("代码"),
        "confirm": MessageLookupByLibrary.simpleMessage("确定"),
        "connectTimeout": MessageLookupByLibrary.simpleMessage("连接设备超时"),
        "deviceList": MessageLookupByLibrary.simpleMessage("蓝牙列表"),
        "deviceNotFound":
            MessageLookupByLibrary.simpleMessage("搜寻不到设备，请确定设备在您的周围"),
        "scanAgain": MessageLookupByLibrary.simpleMessage("重新扫描"),
        "searchDevice": MessageLookupByLibrary.simpleMessage("搜索设备"),
        "searchDeviceTip": MessageLookupByLibrary.simpleMessage("请先搜索并选择设备"),
        "selectDeviceTip": MessageLookupByLibrary.simpleMessage("请选择设备"),
        "selectedDevice": MessageLookupByLibrary.simpleMessage("选择蓝牙设备"),
        "stopScan": MessageLookupByLibrary.simpleMessage("停止扫描"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("未知设备"),
        "unknownError": MessageLookupByLibrary.simpleMessage("未知错误")
      };
}
