import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'bloc/test_bloc.dart';
import 'bloc/test_bloc.dart';
import 'provider/test_provider.dart';

void main() {
  // TestCubit.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // child: BlocCubitWidget(),
          child: BlocWrapper(),
        ),
      ),
    );
    // return ChangeNotifierProvider(
    //   create: (context) => TestProvider(),
    //   child: MaterialApp(
    //     title: 'Flutter Demo',
    //     home: const MyHomePage(),
    //   ),
    // );
  }
}

final class TestFutureProvider extends StatelessWidget {
  const TestFutureProvider({super.key});

  Future<int?> _test() async {
    await Future.delayed(const Duration(seconds: 1));
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<int?>(
      create: (context) => _test(),
      initialData: null,
      child: const TestFutureProvider2(),
    );
  }
}

final class TestFutureProvider2 extends StatelessWidget {
  const TestFutureProvider2({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<int?>();
    return Text('Value: $value');
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Consumer<TestProvider>(
              builder: (context, provider, child) => Text(
                '${provider.list.join(', ')}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const TestFutureProvider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TestProvider>().add(1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
