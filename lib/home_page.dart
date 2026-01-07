import 'package:flutter/material.dart';
import 'leak_examples/leak_animation_page.dart';
import 'leak_examples/leak_circular_ref_page.dart';
import 'leak_examples/leak_context_page.dart';
import 'leak_examples/leak_controllers.dart';
import 'leak_examples/leak_eventbus_page.dart';
import 'leak_examples/leak_future_page.dart';
import 'leak_examples/leak_global_key_page.dart';
import 'leak_examples/leak_image_cache_page.dart';
import 'leak_examples/leak_isolate_page.dart';
import 'leak_examples/leak_observer_page.dart';
import 'leak_examples/leak_overlay_page.dart';
import 'leak_examples/leak_provider_page.dart';
import 'leak_examples/leak_singleton_page.dart';
import 'leak_examples/leak_large_list_page.dart';
import 'leak_examples/leak_closure_page.dart';
import 'leak_examples/leak_renderobject_page.dart';
import 'leak_examples/leak_native_android_page.dart';
import 'leak_examples/leak_native_ios_page.dart';
import 'leak_examples/leak_stream_page.dart';
import 'leak_examples/leak_timer_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final pages = const [
    ("Controller", LeakControllerPage()),
    ("Stream", LeakStreamPage()),
    ("Timer", LeakTimerPage()),
    ("Context (async)", LeakContextPage()),
    ("Image Cache", LeakImageCachePage()),
    ("Circular Ref", LeakCircularRefPage()),
    ("Provider/Service", LeakProviderPage()),
    ("Overlay Entry", LeakOverlayPage()),
    ("EventBus", LeakEventBusPage()),
    ("GlobalKey", LeakGlobalKeyPage()),
    ("Animation/Ticker", LeakAnimationPage()),
    ("Future closure", LeakFuturePage()),
    ("Isolate", LeakIsolatePage()),
    ("WidgetsBindingObserver", LeakObserverPage()),
    ("Singleton/Service", LeakSingletonPage()),
    ("Large List", LeakLargeListPage()),
    ("Closure capture", LeakClosurePage()),
    ("Custom RenderObject", LeakRenderObjectPage()),
    ("Native: Android", LeakNativeAndroidPage()),
    ("Native: iOS", LeakNativeIOSPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Leak Demo')),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, i) {
          final title = pages[i].$1;
          final page = pages[i].$2;
          return ListTile(
            title: Text(title),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            ),
          );
        },
      ),
    );
  }
}
