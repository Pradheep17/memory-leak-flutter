import 'dart:async';
import 'package:flutter/material.dart';

class LeakStreamPage extends StatefulWidget {
  const LeakStreamPage({super.key});

  @override
  State<LeakStreamPage> createState() => _LeakStreamPageState();
}

class _LeakStreamPageState extends State<LeakStreamPage> {
  bool _fix = false;
  late StreamController<int> _controller;
  StreamSubscription<int>? _sub;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>();
    _sub = _controller.stream.listen((v) => print('Received: $v'));
    _controller.add(1);
  }

  @override
  void dispose() {
    if (_fix) {
      _sub?.cancel();
      _controller.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: const Center(child: Text('StreamController leak demo')),
    );
  }
}
