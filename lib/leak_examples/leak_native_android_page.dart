import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeakNativeAndroidPage extends StatefulWidget {
  const LeakNativeAndroidPage({super.key});
  @override
  State<LeakNativeAndroidPage> createState() => _LeakNativeAndroidPageState();
}

class _LeakNativeAndroidPageState extends State<LeakNativeAndroidPage> {
  static const _channel = MethodChannel('memory_leak/native');
  bool _fix = false;

  Future<void> _startNativeLeak() async {
    try {
      await _channel.invokeMethod('startLeak');
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopNativeLeak() async {
    try {
      await _channel.invokeMethod('stopLeak');
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    if (_fix) {
      _stopNativeLeak();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Android Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _startNativeLeak,
              child: const Text('Start native leak'),
            ),
            ElevatedButton(
              onPressed: _stopNativeLeak,
              child: const Text('Stop native leak'),
            ),
          ],
        ),
      ),
    );
  }
}
