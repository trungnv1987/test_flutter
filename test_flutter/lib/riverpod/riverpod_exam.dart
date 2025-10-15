import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_flutter/common/test_state.dart';

final helloWorldProvider = Provider<TestState>((_) => TestState.initial());

final class TestRiverpodApp extends StatelessWidget {
  const TestRiverpodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
      home: Scaffold(
        body: Center(
          // child: TestRiverpodWidget(),
          child: HookAnimatedWidget(),
        ),
      ),
    ));
  }
}

final class HookAnimatedWidget extends HookWidget {
  const HookAnimatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: Duration(seconds: 2));

    useEffect(() {
      controller.repeat(reverse: true);
      return controller.dispose;
    }, [controller]);

    return FadeTransition(
      opacity: controller,
      child: FlutterLogo(size: 100),
    );
  }
}

final class TestRiverpodWidget extends HookConsumerWidget {
  const TestRiverpodWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = useState(0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text(ref.watch(helloWorldProvider).value.toString()),
        Text(counter.value.toString()),
        ElevatedButton(
            onPressed: () => counter.value++, child: Text("Increment")),
      ],
    );
  }
}
