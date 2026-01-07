import 'package:flutter/material.dart';

class LeakControllerPage extends StatefulWidget {
  const LeakControllerPage({super.key});

  @override
  State<LeakControllerPage> createState() => _LeakControllerPageState();
}

class _LeakControllerPageState extends State<LeakControllerPage> {
  bool _fix = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    if (_fix) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controller Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(controller: _controller),
      ),
    );
  }
}
