import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App with Inherited Widget'),
      ),
      body: Center(
        child: CounterManager(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterLabel(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IncrementButton(),
                  DecrementButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterManager extends StatefulWidget {
  final Widget child;

  CounterManager({required this.child});

  static CounterManagerState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>()!.data;
  }

  @override
  CounterManagerState createState() => CounterManagerState();
}

class CounterManagerState extends State<CounterManager> {
  int _counter = 0;

  void increment() {
    if (_counter == 9) {
      // Increment and then show the dialog
      setState(() {
        _counter++;
      });
      _showDialog("You cannot increment more.");
    } else if (_counter < 10) {
      setState(() {
        _counter++;
      });
    }
  }

  void decrement() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    } else {
      _showDialog("You cannot decrement more.");
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      data: this,
      child: widget.child,
    );
  }
}

class CounterProvider extends InheritedWidget {
  final CounterManagerState data;

  CounterProvider({required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return true;
  }
}

class CounterLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = CounterManager.of(context);
    return Text(
      'Counter: ${state._counter}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class IncrementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = CounterManager.of(context);
    return ElevatedButton(
      onPressed: state._counter < 10 ? () => state.increment() : null,
      child: Text('+'),
    );
  }
}

class DecrementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = CounterManager.of(context);
    return ElevatedButton(
      onPressed: state._counter > 0 ? () => state.decrement() : null,
      child: Text('-'),
    );
  }
}
