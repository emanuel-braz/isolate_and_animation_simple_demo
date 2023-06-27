import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

int value = 0;

int fibo(int n) {
  value = value + 1;
  if (n == 0 || n == 1) return n;
  return fibo(n - 1) + fibo(n - 2);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Isolate, Animations and Fibonacci'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _FlutterAnimation(),
          _FiboButtons(),
        ],
      ),
    );
  }
}

class _FiboButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(double.maxFinite, 90),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () => fibo(42), // it executes 866.988.873 times
            child: const Text('Fibonacci without Isolate'),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(double.maxFinite, 90),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () => compute(fibo, 42), // it executes 866.988.873 times
            child: const Text('Fibonacci with Isolate'),
          ),
        ],
      ),
    );
  }
}

class _FlutterAnimation extends StatefulWidget {
  @override
  State<_FlutterAnimation> createState() => _FlutterAnimationState();
}

class _FlutterAnimationState extends State<_FlutterAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
    ..repeat();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: const FlutterLogo(size: 200),
    );
  }
}
