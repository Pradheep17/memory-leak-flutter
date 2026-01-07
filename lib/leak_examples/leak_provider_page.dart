import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExampleService {
  final StreamController<int> _c = StreamController();
  Stream<int> get stream => _c.stream;
  void add(int v) => _c.add(v);
  void dispose() => _c.close();
}

class LeakProviderPage extends StatefulWidget {
  const LeakProviderPage({super.key});
  @override
  State<LeakProviderPage> createState() => _LeakProviderPageState();
}

class _LeakProviderPageState extends State<LeakProviderPage> {
  bool _fix = false;

  @override
  Widget build(BuildContext context) {
    // create provider here for demo; in real apps provider often created at app root
    return Provider<ExampleService>(
      create: (_) => ExampleService(),
      dispose: (_, s) {
        if (_fix) s.dispose();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider Leak'),
          actions: [
            Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
          ],
        ),
        body: const ProviderChild(),
      ),
    );
  }
}

class ProviderChild extends StatefulWidget {
  const ProviderChild({super.key});
  @override
  State<ProviderChild> createState() => _ProviderChildState();
}

class _ProviderChildState extends State<ProviderChild> {
  StreamSubscription<int>? _sub;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final svc = Provider.of<ExampleService>(context);
    _sub = svc.stream.listen((v) {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () =>
            Provider.of<ExampleService>(context, listen: false).add(1),
        child: const Text('Add'),
      ),
    );
  }
}
