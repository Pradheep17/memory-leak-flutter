import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class LeakIsolatePage extends StatefulWidget {
  const LeakIsolatePage({super.key});
  @override
  State<LeakIsolatePage> createState() => _LeakIsolatePageState();
}

class _LeakIsolatePageState extends State<LeakIsolatePage> {
  bool _fix = false;
  Isolate? _isolate;
  ReceivePort? _port;

  Future<void> _spawn() async {
    _port = ReceivePort();
    _isolate = await Isolate.spawn(_isolateEntry, _port!.sendPort);
    _port!.listen((m) => print('msg: \$m'));
  }

  static void _isolateEntry(SendPort p) {
    // keep isolate alive
    Timer.periodic(const Duration(seconds: 1), (_) => p.send('tick'));
  }

  @override
  void dispose() {
    if (_fix) {
      _isolate?.kill(priority: Isolate.immediate);
      _port?.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _spawn,
          child: const Text('Spawn Isolate'),
        ),
      ),
    );
  }
}
