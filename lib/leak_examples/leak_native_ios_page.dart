import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeakNativeIOSPage extends StatefulWidget {
  const LeakNativeIOSPage({super.key});
  @override
  State<LeakNativeIOSPage> createState() => _LeakNativeIOSPageState();
}

class _LeakNativeIOSPageState extends State<LeakNativeIOSPage> {
  static const _channel = MethodChannel('memory_leak/native_ios');
  bool _fix = false;

  Future<void> _start() async {
    try {
      await _channel.invokeMethod('startLeak');
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stop() async {
    try {
      await _channel.invokeMethod('stopLeak');
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    if (_fix) _stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native iOS Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _start,
              child: const Text('Start iOS leak'),
            ),
            ElevatedButton(
              onPressed: _stop,
              child: const Text('Stop iOS leak'),
            ),
          ],
        ),
      ),
    );
  }
}
