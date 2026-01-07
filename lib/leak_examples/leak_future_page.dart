import 'package:flutter/material.dart';

class LeakFuturePage extends StatefulWidget {
  const LeakFuturePage({super.key});
  @override
  State<LeakFuturePage> createState() => _LeakFuturePageState();
}

class _LeakFuturePageState extends State<LeakFuturePage> {
  bool _fix = false;

  @override
  void initState() {
    super.initState();
    _doLong();
  }

  Future<void> _doLong() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;
    if (!_fix) setState(() {}); // hold onto state closure if not fixed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Closure Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: const Center(child: Text('Future closure example')),
    );
  }
}
