import 'package:flutter/foundation.dart';

import 'package:audioplayers/audio_cache.dart';

/// Plays a sound.
Future<void> play(String source) async {
  if (kIsWeb) return;
  final AudioCache cache = AudioCache();
  await cache.play("sounds/$source.mp3");
}
