import 'package:flutter/foundation.dart';

class SymbolChangeNotifier extends ChangeNotifier
    implements ValueListenable<String?> {
  SymbolChangeNotifier(this._value);

  @override
  String? get value => _value;
  String? _value;

  set value(String? newValue) {
    _value = newValue;
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}
