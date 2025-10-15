import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/bloc/test_bloc.dart';

void main() {
  // group('CounterBloc', () {
  //   blocTest<ValueBloc, TestState>(
  //     'emits [1] when CounterIncrementPressed is added',
  //     build: () => ValueBloc(),
  //     act: (bloc) => bloc.add(TestBlocIncrementEvent(value: 1)),
  //     expect: () => [TestState(value: 1)],
  //   );
  // });

  testWidgets("BlocWrapper", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: BlocWrapper()));
    await tester.tap(find.byKey(const Key('add_button')));
    await tester.pump();
    expect(find.text('Value: 2'), findsOneWidget);
  });
}
 