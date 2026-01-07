import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LeakImageCachePage extends StatefulWidget {
  const LeakImageCachePage({super.key});

  @override
  State<LeakImageCachePage> createState() => _LeakImageCachePageState();
}

class _LeakImageCachePageState extends State<LeakImageCachePage> {
  bool _fix = false;
  final List<String> _images = List.generate(
    200,
    (i) => 'https://picsum.photos/seed/$i/1024/768',
  );

  @override
  void dispose() {
    if (_fix) {
      imageCache.clear();
      imageCache.clearLiveImages();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Cache Leak'),
        actions: [
          Switch(value: _fix, onChanged: (v) => setState(() => _fix = v)),
        ],
      ),
      body: ListView.builder(
        itemCount: _images.length,
        itemBuilder: (context, i) => SizedBox(
          height: 200,
          child: CachedNetworkImage(imageUrl: _images[i], fit: BoxFit.cover),
        ),
      ),
    );
  }
}
