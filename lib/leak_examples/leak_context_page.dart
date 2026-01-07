import 'package:flutter/material.dart';

class LeakContextPage extends StatefulWidget {
  const LeakContextPage({super.key});

  @override
  State<LeakContextPage> createState() => _LeakContextPageState();
}

class _LeakContextPageState extends State<LeakContextPage> {
  bool _fix = false;

  Future<void> _longOp() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;
    if (!_fix) {
      // simulate using context after unmounted -> closure holds reference
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Done')));
    }
  }

  @override
  void initState() {
    super.initState();
    _longOp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Context/Async Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: const Center(child: Text('Async context closure demo')),
    );
  }
}
