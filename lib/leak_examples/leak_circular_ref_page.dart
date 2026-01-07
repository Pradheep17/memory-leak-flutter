import 'package:flutter/material.dart';

class A {
  B? b;
}

class B {
  A? a;
}

class LeakCircularRefPage extends StatefulWidget {
  const LeakCircularRefPage({super.key});
  @override
  State<LeakCircularRefPage> createState() => _LeakCircularRefPageState();
}

class _LeakCircularRefPageState extends State<LeakCircularRefPage> {
  bool _fix = false;
  A? _a;

  @override
  void initState() {
    super.initState();
    _a = A();
    final b = B();
    _a!.b = b;
    b.a = _a; // circular
  }

  @override
  void dispose() {
    if (_fix) {
      // break the circular reference
      _a?.b?.a = null;
      _a?.b = null;
      _a = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular Reference'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: const Center(child: Text('Circular ref demo')),
    );
  }
}
