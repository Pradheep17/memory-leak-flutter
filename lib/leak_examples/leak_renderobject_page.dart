import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Minimal example: we store children reference and don't release
class LeakyRenderWidget extends SingleChildRenderObjectWidget {
  const LeakyRenderWidget({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => _LeakyRenderObject();
}

class _LeakyRenderObject extends RenderProxyBox {
  // pretend we keep references to child data
  Object? _leaked;

  void hold(Object o) {
    _leaked = o; // never released until GC if ever
  }
}

class LeakRenderObjectPage extends StatefulWidget {
  const LeakRenderObjectPage({super.key});
  @override
  State<LeakRenderObjectPage> createState() => _LeakRenderObjectPageState();
}

class _LeakRenderObjectPageState extends State<LeakRenderObjectPage> {
  bool _fix = false;
  final List<Object> _leaks = [];

  void _createLeak() {
    _leaks.add(List.generate(10000, (i) => i));
  }

  @override
  void dispose() {
    if (_fix) _leaks.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom RenderObject Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _createLeak,
          child: const Text('Create large object'),
        ),
      ),
    );
  }
}
