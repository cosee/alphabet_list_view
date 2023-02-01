import 'package:flutter/foundation.dart';

/// SymbolChangeNotifier
class SymbolChangeNotifier extends ChangeNotifier
    implements ValueListenable<String?> {
  /// Constructor of SymbolChangeNotifier
  SymbolChangeNotifier([this._value]);

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
