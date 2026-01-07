import 'dart:async';
import 'package:flutter/material.dart';

class LonelyService {
  static final LonelyService instance = LonelyService._();
  LonelyService._();
  final StreamController<int> _c = StreamController.broadcast();
  Stream<int> get stream => _c.stream;
  void add(int v) => _c.add(v);
  void dispose() => _c.close();
}

class LeakSingletonPage extends StatefulWidget {
  const LeakSingletonPage({super.key});
  @override
  State<LeakSingletonPage> createState() => _LeakSingletonPageState();
}

class _LeakSingletonPageState extends State<LeakSingletonPage> {
  bool _fix = false;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _sub = LonelyService.instance.stream.listen((_) {});
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
        title: const Text('Singleton Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => LonelyService.instance.add(1),
          child: const Text('Add'),
        ),
      ),
    );
  }
}
