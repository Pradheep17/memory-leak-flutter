import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

final EventBus _bus = EventBus();

class LeakEventBusPage extends StatefulWidget {
  const LeakEventBusPage({super.key});
  @override
  State<LeakEventBusPage> createState() => _LeakEventBusPageState();
}

class _LeakEventBusPageState extends State<LeakEventBusPage> {
  bool _fix = false;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _sub = _bus.on<String>().listen((s) => print('Event: \$s'));
  }

  @override
  void dispose() {
    if (_fix) _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventBus Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _bus.fire('hi'),
          child: const Text('Fire Event'),
        ),
      ),
    );
  }
}
