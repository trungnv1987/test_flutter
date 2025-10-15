import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class TetstBlocEvent {}

final class TestBlocIncrementEvent extends TetstBlocEvent {
  final int value;
  TestBlocIncrementEvent({required this.value});
}

final class TestBlocDecrementEvent extends TetstBlocEvent {
  final int value;
  TestBlocDecrementEvent({required this.value});
}

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

final class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestState.initial());

  void increment() {
    emit(TestState(value: state.value + 1));
  }
}

final class BlocCubitWidget extends StatelessWidget {
  const BlocCubitWidget({super.key});

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

final class BlocWrapper extends StatelessWidget {
  const BlocWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ValueBloc(),
        child: Builder(builder: (context) {
          final bloc = context.read<ValueBloc>();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<ValueBloc, TestState>(
                builder: (context, state) {
                  return Text('Value: ${state.value}');
                },
              ),
              IconButton(
                key: const Key('add_button'),
                onPressed: () => bloc.add(TestBlocIncrementEvent(value: 1)),
                icon: const Icon(Icons.add),
              ),
              IconButton(
                key: const Key('remove_button'),
                onPressed: () => bloc.add(TestBlocDecrementEvent(value: 1)),
                icon: const Icon(Icons.remove),
              ),
            ],
          );
        }));
  }
}

final class ValueBloc extends Bloc<TetstBlocEvent, TestState> {
  ValueBloc() : super(TestState.initial()) {
    on<TestBlocIncrementEvent>(_onIncrement);
    on<TestBlocDecrementEvent>(_onDecrement);
  }

  Future<void> _onIncrement(
      TestBlocIncrementEvent event, Emitter<TestState> emit) async {
    emit(TestState(value: state.value + event.value));
  }

  Future<void> _onDecrement(
      TestBlocDecrementEvent event, Emitter<TestState> emit) async {
    emit(TestState(value: state.value - event.value));
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
