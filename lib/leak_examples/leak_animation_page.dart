import 'package:flutter/material.dart';

class LeakAnimationPage extends StatefulWidget {
  const LeakAnimationPage({super.key});
  @override
  State<LeakAnimationPage> createState() => _LeakAnimationPageState();
}

class _LeakAnimationPageState extends State<LeakAnimationPage>
    with SingleTickerProviderStateMixin {
  bool _fix = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    if (_fix) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation/Ticker Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: FadeTransition(
          opacity: _controller,
          child: const Text('Animating'),
        ),
      ),
    );
  }
}
