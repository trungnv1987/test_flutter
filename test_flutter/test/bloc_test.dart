import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/bloc/test_bloc.dart';

void main() {
  group('CounterBloc', () {
    blocTest<ValueBloc, TestState>(
      'emits [1] when CounterIncrementPressed is added',
      build: () => ValueBloc(),
      act: (bloc) => bloc.add(TestBlocIncrementEvent(value: 1)),
      expect: () => [TestState(value: 1)],
    );
  });
}
