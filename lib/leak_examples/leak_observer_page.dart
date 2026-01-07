import 'package:flutter/material.dart';

class LeakObserverPage extends StatefulWidget {
  const LeakObserverPage({super.key});
  @override
  State<LeakObserverPage> createState() => _LeakObserverPageState();
}

class _LeakObserverPageState extends State<LeakObserverPage>
    with WidgetsBindingObserver {
  bool _fix = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    if (_fix) WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WidgetsBindingObserver Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: const Center(child: Text('Observer demo')),
    );
  }
}
