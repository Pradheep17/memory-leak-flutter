import 'package:flutter/material.dart';

class LeakLargeListPage extends StatefulWidget {
  const LeakLargeListPage({super.key});
  @override
  State<LeakLargeListPage> createState() => _LeakLargeListPageState();
}

class _LeakLargeListPageState extends State<LeakLargeListPage> {
  bool _fix = false;
  final List<int> _items = [];

  void _addBulk() {
    _items.addAll(List.generate(100000, (i) => i));
    setState(() {});
  }

  @override
  void dispose() {
    if (_fix) _items.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Large List Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: _addBulk, child: const Text('Add Many')),
          ],
        ),
      ),
    );
  }
}
