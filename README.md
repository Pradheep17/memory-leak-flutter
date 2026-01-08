# memory_leak_identifier

A new Flutter project.

## Getting Started

I created the complete project in a canvas titled "Flutter Memory Leak Demo — Full Project". It includes:

All 20+ leak scenarios we discussed (Dart-level + native-related).

Both leaky and fixed versions on each screen (toggle with the Fix switch).

Android Kotlin and iOS Swift native snippets to simulate native leaks (method channels included).

pubspec.yaml, main.dart, home_page.dart, and every example page under lib/leak_examples/.

Next steps for you:

Open the canvas “Flutter Memory Leak Demo — Full Project” (you’ll see the full project files there).

Copy the files into a new Flutter project (replace/merge as needed).

For Android/iOS native tests, paste the Kotlin/Swift snippets into your platform code (android/app/src/... and ios/Runner/...) and rebuild.

Run in profile mode: flutter run --profile.

Open DevTools (flutter pub global run devtools) and monitor Memory → Heap while you navigate pages and toggle the Fix switches.

**How to use**

Create a new Flutter project and replace contents with files below, or copy the files into your project.

Run in profile mode:

**flutter run --profile
**
Launch DevTools:

**flutter pub global run devtools
**
Open the provided URL and go to Memory. Navigate between pages repeatedly. Toggle the Fix switch on each page to compare leaky vs fixed behavior.

Files in this doc

pubspec.yaml

lib/main.dart

lib/home_page.dart

lib/leak_examples/* (20+ example pages)

android native snippets (Kotlin) to demo native leaks

ios native snippets (Swift) to demo native leaks
