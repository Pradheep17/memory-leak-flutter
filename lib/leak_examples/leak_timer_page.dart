import 'dart:async';
import 'package:flutter/material.dart';

class LeakTimerPage extends StatefulWidget {
  const LeakTimerPage({super.key});

  @override
  State<LeakTimerPage> createState() => _LeakTimerPageState();
}

class _LeakTimerPageState extends State<LeakTimerPage> {
  bool _fix = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => print('tick'));
  }

  @override
  void dispose() {
    if (_fix) _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: const Center(child: Text('Timer periodic leak demo')),
    );
  }
}
