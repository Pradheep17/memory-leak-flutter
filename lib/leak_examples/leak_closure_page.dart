import 'package:flutter/material.dart';

class LeakClosurePage extends StatefulWidget {
  const LeakClosurePage({super.key});
  @override
  State<LeakClosurePage> createState() => _LeakClosurePageState();
}

class _LeakClosurePageState extends State<LeakClosurePage> {
  bool _fix = false;

  void _delayedSnack() {
    Future.delayed(const Duration(seconds: 10), () {
      if (!mounted) return;
      if (!_fix)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Hi')));
    });
  }

  @override
  void initState() {
    super.initState();
    _delayedSnack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Closure Capture Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: const Center(child: Text('Closure capture demo')),
    );
  }
}
