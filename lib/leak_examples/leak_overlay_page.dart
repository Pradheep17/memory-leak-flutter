import 'package:flutter/material.dart';

class LeakOverlayPage extends StatefulWidget {
  const LeakOverlayPage({super.key});
  @override
  State<LeakOverlayPage> createState() => _LeakOverlayPageState();
}

class _LeakOverlayPageState extends State<LeakOverlayPage> {
  bool _fix = false;
  OverlayEntry? _entry;

  void _showOverlay() {
    _entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 100,
        left: 50,
        child: Material(child: Text('Overlay')),
      ),
    );
    Overlay.of(context)!.insert(_entry!);
  }

  @override
  void dispose() {
    if (_fix) _entry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showOverlay,
          child: const Text('Show Overlay'),
        ),
      ),
    );
  }
}
