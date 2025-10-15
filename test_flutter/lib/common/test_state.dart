import 'package:flutter/foundation.dart';

final class TestState {
  final int value;
  TestState({required this.value});

  factory TestState.initial() => TestState(value: 0);

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! TestState) return false;
    debugPrint('TestState ==: ${other.value}');
    return other.value == value;
  }
}
