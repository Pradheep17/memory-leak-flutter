import 'package:flutter/material.dart';

class LeakGlobalKeyPage extends StatefulWidget {
  const LeakGlobalKeyPage({super.key});
  @override
  State<LeakGlobalKeyPage> createState() => _LeakGlobalKeyPageState();
}

class _LeakGlobalKeyPageState extends State<LeakGlobalKeyPage> {
  bool _fix = false;
  final List<GlobalKey> _keys = [];

  void _addKey() {
    final k = GlobalKey();
    _keys.add(k);
    // Creating many global keys and keeping them simulates leaking heavy widget states
  }

  @override
  void dispose() {
    if (_fix) _keys.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GlobalKey Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _addKey,
          child: const Text('Add GlobalKey'),
        ),
      ),
    );
  }
}
