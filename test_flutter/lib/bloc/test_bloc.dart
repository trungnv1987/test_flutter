import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class TestState {
  final int value;
  TestState({required this.value});

  factory TestState.initial() => TestState(value: 0);
}

final class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestState.initial());

  void increment() {
    emit(TestState(value: state.value + 1));
  }
}

final class BlocWidget extends StatelessWidget {
  const BlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestCubit(),
      child: Builder(builder: (context) {
        final cubit = context.watch<TestCubit>();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Value: ${cubit.state.value}'),
            IconButton(
              onPressed: () => cubit.increment(),
              icon: const Icon(Icons.add),
            ),
          ],
        );
      }),
    );
  }
}

base class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('onEvent: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('onTransition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('onClose: $bloc');
    super.onClose(bloc);
  }
}
